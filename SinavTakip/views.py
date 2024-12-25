from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout
from django.contrib.auth.decorators import login_required
from django.contrib.admin.views.decorators import staff_member_required
from django.contrib import messages
from django.contrib.auth.models import User
from django.db import models, transaction
from django.utils import timezone
from .models import (
    Classroom, Feature, ClassroomFeature, 
    Department, DepartmentUser, ProcessLog,
    Lesson, LessonDepartment, ExamDate, ExamTime,
    ProcessType, Request, ClassroomExamTime
)
from django.http import JsonResponse
from django.views.decorators.http import require_http_methods
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.db.models import Q

def user_login(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        
        try:
            user = authenticate(request, username=username, password=password)
            
            if user is not None:
                if user.is_approved or user.is_staff:
                    auth_login(request, user)
                    return redirect('sinavtakip:index')
                else:
                    messages.warning(request, 'Hesabınız henüz onaylanmamış. Lütfen yönetici onayını bekleyin.')
            else:
                messages.error(request, 'Kullanıcı adı veya şifre hatalı!')
                
        except Exception as e:
            messages.error(request, 'Bir hata oluştu. Lütfen daha sonra tekrar deneyin.')
            
    return render(request, 'login.html')

@login_required
def index(request):
    return render(request, 'index.html')

@login_required
def derslikler(request):
    if not request.user.is_approved:
        messages.warning(request, 'Hesabınız henüz onaylanmadı. Onaylandıktan sonra derslik talebinde bulunabilirsiniz.')
        return redirect('sinavtakip:taleplerim')
        
    classrooms = Classroom.objects.prefetch_related(
        'features',  
        'features__feature'  
    ).all().order_by('title')
    
    features = Feature.objects.all()
    exam_dates = ExamDate.objects.all().order_by('date')
    lessons = Lesson.objects.all()
    
    return render(request, 'derslikler.html', {
        'classrooms': classrooms,
        'features': features,
        'exam_dates': exam_dates,
        'lessons': lessons,
    })

@login_required
def dersler(request):
    if not request.user.is_staff:
        return redirect('sinavtakip:index')
    
    search_query = request.GET.get('search', '')
    department_filter = request.GET.get('department', '')
    grade_filter = request.GET.get('grade', '')
    
    lessons = Lesson.objects.prefetch_related(
        models.Prefetch(
            'lessondepartment_set',
            queryset=LessonDepartment.objects.select_related('department')
        )
    )
    
    if search_query:
        lessons = lessons.filter(name__icontains=search_query)
    
    if department_filter:
        lessons = lessons.filter(lessondepartment__department_id=department_filter)
        
    if grade_filter:
        lessons = lessons.filter(grade=grade_filter)
    
    lessons = lessons.order_by('name')
    all_departments = Department.objects.all()
    
    return render(request, 'dersler.html', {
        'lessons': lessons,
        'all_departments': all_departments,
        'search_query': search_query,
        'department_filter': department_filter,
        'grade_filter': grade_filter
    })

@login_required
@require_http_methods(["POST"])
def ders_ekle(request):
    if not request.user.is_staff:
        return redirect('sinavtakip:dersler')
    
    name = request.POST.get('name')
    department_id = request.POST.get('department')
    grade = request.POST.get('grade')
    term = request.POST.get('term')
    
    try:
        with transaction.atomic():
            lesson = Lesson.objects.create(
                name=name,
                grade=grade,
                term=term,
                created_date=timezone.now()
            )
            
            if department_id:
                LessonDepartment.objects.create(
                    lesson=lesson,
                    department_id=department_id
                )
            
            ProcessLog.objects.create(
                user=request.user,
                process_type=ProcessType.CREATE,
                process_time=timezone.now(),
                description=f"'{name}' isimli ders '{request.user}' tarafından eklendi.",
            )

            messages.success(request, 'Ders başarıyla eklendi.')
    except Exception as e:
        messages.error(request, f'Ders eklenirken bir hata oluştu: {str(e)}')

    return redirect('sinavtakip:dersler')

@login_required
def taleplerim(request):
    try:
        talepler = Request.objects.filter(user=request.user)\
            .select_related(
                'classroom',
                'requested_lesson',
                'exam_time',
                'exam_time__date',
            ).order_by('-request_date')
        
        return render(request, 'taleplerim.html', {
            'talepler': talepler
        })
    except Exception as e:
        messages.error(request, 'Talepleriniz görüntülenirken bir hata oluştu.')
        return redirect('sinavtakip:index')

@login_required
def tum_talepler(request):
    if not request.user.is_staff:
        return redirect('sinavtakip:index')
    
    search_query = request.GET.get('search', '')
    status_filter = request.GET.get('status', '')
    date_filter = request.GET.get('date', '')
    
    talepler = Request.objects.select_related(
        'classroom',
        'requested_lesson',
        'exam_time',
        'exam_time__date',
        'user'
    )
    
    if search_query:
        talepler = talepler.filter(
            Q(user__username__icontains=search_query) |
            Q(classroom__title__icontains=search_query) |
            Q(requested_lesson__name__icontains=search_query)
        )
    
    if status_filter:
        talepler = talepler.filter(status=status_filter)
        
    if date_filter:
        talepler = talepler.filter(exam_time__date__date=date_filter)
    
    talepler = talepler.order_by('-request_date')
    
    return render(request, 'tum_talepler.html', {
        'talepler': talepler,
        'search_query': search_query,
        'status_filter': status_filter,
        'date_filter': date_filter
    })

@login_required
@require_http_methods(["POST"])
def derslik_ekle(request):
    if not request.user.is_staff:
        return redirect('sinavtakip:derslikler')
    
    try:
        with transaction.atomic():
            title = request.POST.get('title')
            capacity = request.POST.get('capacity')
            features = request.POST.getlist('features[]')  
            
            if not all([title, capacity]):
                messages.warning(request, 'Lütfen gerekli alanları doldurun.')
                return redirect('sinavtakip:derslikler')
            
            derslik = Classroom.objects.create(
                title=title,
                capacity=capacity,
                created_date=timezone.now()
            )
            
            for feature_id in features:
                try:
                    feature = Feature.objects.get(id=feature_id)
                    ClassroomFeature.objects.create(
                        classroom=derslik,
                        feature=feature,
                        created_date=timezone.now()
                    )
                except Feature.DoesNotExist:
                    pass
                except Exception as e:
                    pass
            
            ProcessLog.objects.create(
                user=request.user,
                process_type=ProcessType.CREATE,
                process_time=timezone.now(),
                description=f"'{title}' isimli derslik '{request.user}' tarafından oluşturuldu.",
            )
            
            messages.success(request, 'Derslik başarıyla oluşturuldu.')
    except Exception as e:
        messages.error(request, 'Derslik oluşturulurken bir hata oluştu.')
    
    return redirect('sinavtakip:derslikler')

@login_required
def profil(request):
    department_relation = DepartmentUser.objects.filter(user=request.user).first()
    department = department_relation.department if department_relation else None
    
    onaylanan_talepler = Request.objects.filter(
        user=request.user,
        status=1
    ).select_related(
        'classroom',
        'requested_lesson',
        'exam_time',
        'exam_time__date'
    ).order_by('-request_date')
    
    return render(request, 'profil.html', {
        'onaylanan_talepler': onaylanan_talepler,
        'department': department
    })

@login_required
def talep_olustur(request, classroom_id, lesson_id, exam_time_id):
    if request.method == 'POST':
        try:
            with transaction.atomic():
                
                derslik = get_object_or_404(Classroom, id=classroom_id)
                lesson = get_object_or_404(Lesson, id=lesson_id)
                exam_time = get_object_or_404(ExamTime, id=exam_time_id)
                
                existing_request = Request.objects.filter(
                    classroom=derslik,
                    exam_time=exam_time,
                    status=0
                ).exists()
                
                if existing_request:
                    return JsonResponse({'error': 'Bu derslik ve saat dilimi için zaten bir talep bulunmaktadır'}, status=400)
                
                new_request = Request.objects.create(
                    classroom=derslik,
                    request_date=timezone.now(),
                    requested_lesson=lesson,
                    exam_time=exam_time,
                    user=request.user,
                    status=0  
                )
                
                ProcessLog.objects.create(
                    user=request.user,
                    process_type=ProcessType.CREATE,
                    process_time=timezone.now(),
                    description=f"'{request.user}' adlı kullanıcı '{derslik.title}' dersliği için talep oluşturdu.",
                )
            
                
                return JsonResponse({'message': 'Talep başarıyla oluşturuldu'})
                
        except Exception as e:
            return JsonResponse({'error': 'Talep oluşturulurken bir hata oluştu'}, status=500)
    
    return JsonResponse({'error': 'Geçersiz istek metodu'}, status=405)

@login_required
def talep_iptal(request, request_id):
    try:
        with transaction.atomic():
            talep = get_object_or_404(Request, id=request_id, user=request.user)
            
            if talep.status != 0:
                messages.error(request, "Bu talep iptal edilemez.")
                return redirect('sinavtakip:taleplerim')
            
            talep.delete()
            
            ProcessLog.objects.create(
                user=request.user,
                process_type=ProcessType.DELETE,
                process_time=timezone.now(),
                description=f"'{request.user}' adlı kullanıcı talebini iptal etti.",
            )
            
            messages.success(request, 'Talep başarıyla iptal edildi.')
    except Exception as e:
        messages.error(request, 'Talep iptal edilirken bir hata oluştu.')
    
    return redirect('sinavtakip:taleplerim')

@login_required
def talep_onayla(request, request_id):
    if not request.user.is_staff:
        return redirect('sinavtakip:tum_talepler')

    try:
        with transaction.atomic():
            talep = get_object_or_404(Request, pk=request_id)
            
            talep.status = 1
            talep.save()

            classroom_exam_time, created = ClassroomExamTime.objects.get_or_create(
                classroom=talep.classroom,
                exam_time=talep.exam_time,
                defaults={'is_available': True}
            )
            classroom_exam_time.is_available = False
            classroom_exam_time.save()
            
            ProcessLog.objects.create(
                user=request.user,
                process_type=ProcessType.UPDATE,
                process_time=timezone.now(),
                description=f"'{request.user}' adlı kullanıcı '{talep.user}' kullanıcısının talebini onayladı.",
            )
            
            messages.success(request, 'Talep başarıyla onaylandı.')
    except Exception as e:
        messages.error(request, 'Talep onaylanırken bir hata oluştu.')
    
    return redirect('sinavtakip:tum_talepler')

@login_required
def talep_reddet(request, request_id):
    if not request.user.is_staff:
        return redirect('sinavtakip:tum_talepler')

    try:
        with transaction.atomic():
            talep = get_object_or_404(Request, pk=request_id)
            derslik = talep.classroom
            
            talep.status = 2
            talep.rejection_message = request.POST.get('rejection_message', '')
            talep.save()
            
            derslik.status = False
            derslik.save()
            
            ProcessLog.objects.create(
                user=request.user,
                process_type=ProcessType.UPDATE,
                process_time=timezone.now(),
                description=f"'{request.user}' adlı kullanıcı '{talep.user}' kullanıcısının talebini reddetti.",
            )
            
            messages.success(request, 'Talep başarıyla reddedildi.')
    except Exception as e:
        messages.error(request, 'Talep reddedilirken bir hata oluştu.')
    
    return redirect('sinavtakip:tum_talepler')
    
@login_required
@staff_member_required
def kullanicilar_view(request):
    search_query = request.GET.get('search', '')
    department_filter = request.GET.get('department', '')
    approval_filter = request.GET.get('approval', '')
    
    all_users = User.objects.all()
    
    if search_query:
        all_users = all_users.filter(
            Q(username__icontains=search_query) |
            Q(email__icontains=search_query) |
            Q(first_name__icontains=search_query) |
            Q(last_name__icontains=search_query)
        )
    
    if department_filter:
        all_users = all_users.filter(departmentuser__department_id=department_filter)
        
    if approval_filter:
        is_approved = approval_filter == 'approved'
        all_users = all_users.filter(is_approved=is_approved)
    
    all_users = all_users.order_by('-date_joined')
    pending_users = User.objects.filter(is_approved=False, is_staff=False)
    departments = Department.objects.all()
    
    return render(request, 'kullanicilar.html', {
        'pending_users': pending_users,
        'all_users': all_users,
        'departments': departments,
        'search_query': search_query,
        'department_filter': department_filter,
        'approval_filter': approval_filter
    })

@staff_member_required
def activate_user(request, user_id):
    if request.method == 'POST':
        user = get_object_or_404(User, id=user_id)
        user.is_approved = True
        user.save()
        
        log = ProcessLog(
            user=request.user,
            process_type=ProcessType.UPDATE,
            process_time=timezone.now(),
            description=f'{user.username} kullanıcısı onaylandı.'
        )
        log.save()
        
        messages.success(request, f'{user.username} kullanıcısı başarıyla onaylandı.')
        return redirect('sinavtakip:kullanicilar')
    return redirect('sinavtakip:kullanicilar')

@staff_member_required
def reject_user(request, user_id):
    if request.method == 'POST':
        user = get_object_or_404(User, id=user_id)
        try:
            user.is_active = False
            user.is_approved = False
            user.save()
            
            log = ProcessLog(
                user=request.user,
                process_type=ProcessType.UPDATE,
                process_time=timezone.now(),
                description=f'{user.username} kullanıcısı reddedildi.',
            )
            log.save()
            
            messages.success(request, f'{user.username} kullanıcısı reddedildi.')
        except Exception as e:
            messages.error(request, f'İşlem sırasında bir hata oluştu: {str(e)}')
        
        return redirect('sinavtakip:kullanicilar')
    return redirect('sinavtakip:kullanicilar')

@staff_member_required
def deactivate_user(request, user_id):
    if request.method == 'POST':
        user = get_object_or_404(User, id=user_id)
        if not user.is_staff:
            user.is_approved = False
            user.save()
            
            log = ProcessLog(
                user=request.user,
                process_type=ProcessType.UPDATE,
                process_time=timezone.now(),
                description=f'{user.username} kullanıcısı pasif edildi.'
            )
            log.save()
            
            messages.success(request, f'{user.username} kullanıcısı pasif edildi.')
        else:
            messages.error(request, 'Yönetici hesapları pasif yapılamaz.')
        return redirect('sinavtakip:kullanicilar')
    return redirect('sinavtakip:kullanicilar')

@login_required
@require_http_methods(["POST"])
def ders_sil(request, lesson_id):
    if not request.user.is_staff:
        return redirect('sinavtakip:dersler')

    try:
        with transaction.atomic():
            ders = get_object_or_404(Lesson, pk=lesson_id)
            ders_adi = ders.name
            
            Request.objects.filter(requested_lesson=ders).delete()
            
            LessonDepartment.objects.filter(lesson=ders).delete()
            
            ders.delete()
            
            ProcessLog.objects.create(
                user=request.user,
                process_type=ProcessType.DELETE,
                process_time=timezone.now(),
                description=f"'{ders_adi}' isimli ders '{request.user}' tarafından silindi.",
            )
            
            messages.success(request, 'Ders başarıyla silindi.')
    except Exception as e:
        messages.warning(request, 'Ders silinirken bir hata oluştu.')

    return redirect('sinavtakip:dersler')

@login_required
def get_derslikler(request):
    
    derslikler = Classroom.objects.all().values(
        'id', 
        'title',
        'capacity'
    )
    
    return JsonResponse({
        'success': True,
        'derslikler': list(derslikler)
    })

@login_required
@require_http_methods(["POST"])
def derslik_sil(request, classroom_id):
    if not request.user.is_staff:
        return redirect('sinavtakip:derslikler')

    try:
        with transaction.atomic():
            derslik = get_object_or_404(Classroom, pk=classroom_id)
            derslik_title = derslik.title
            
            Request.objects.filter(classroom=derslik).delete()
            
            ClassroomFeature.objects.filter(classroom=derslik).delete()
            
            derslik.delete()
            
            ProcessLog.objects.create(
                user=request.user,
                process_type=ProcessType.DELETE,
                process_time=timezone.now(),
                description=f"'{derslik_title}' isimli derslik '{request.user}' adlı kullanıcı tarafından silindi.",
            )
            
            messages.success(request, 'Derslik başarıyla silindi.')
    except Exception as e:
        messages.warning(request, 'Derslik silinirken bir hata oluştu.')

    return redirect('sinavtakip:derslikler')

@login_required
@require_http_methods(["GET"])
def get_exam_times(request, date_id, classroom_id):
    if not request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        return JsonResponse({
            'error': 'Bu endpoint sadece AJAX istekleri için kullanılabilir'
        }, status=400)

    try:
        if not classroom_id:
            return JsonResponse({'error': 'Derslik ID gerekli'}, status=400)

        exam_times = ExamTime.objects.filter(date_id=date_id)
        
        unavailable_times = ClassroomExamTime.objects.filter(
            classroom_id=classroom_id,
            exam_time__date_id=date_id,
            is_available=False
        ).values_list('exam_time_id', flat=True)
        
        available_times = exam_times.exclude(id__in=unavailable_times).order_by('time_slot')
        
        times_data = []
        for time in available_times:
            times_data.append({
                'id': time.id,
                'time_slot': str(time.time_slot)
            })
        
        if not times_data:
            return JsonResponse({
                'exam_times': [],
                'message': 'Bu tarih için müsait saat bulunmamaktadır.'
            })

        return JsonResponse({
            'exam_times': times_data
        })
        
    except Exception as e:
        return JsonResponse({
            'error': 'Sınav saatleri alınırken bir hata oluştu'
        }, status=500)

@login_required
def user_logout(request):
    auth_logout(request)
    return render(request, 'login.html')

def user_register(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        email = request.POST.get('email')
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        password1 = request.POST.get('password1')
        password2 = request.POST.get('password2')
        department_id = request.POST.get('department')

        try:
            if not all([username, email, first_name, last_name, password1, password2, department_id]):
                messages.error(request, 'Lütfen tüm alanları doldurun!')
                departments = Department.objects.all()
                return render(request, 'register.html', {'departments': departments})

            if password1 == password2:
                
                user = User.objects.create_user(
                    username=username,
                    email=email,
                    password=password1,
                    first_name=first_name,
                    last_name=last_name,
                    is_active=True,
                    is_approved=False
                )
                
                department = Department.objects.get(id=department_id)
                DepartmentUser.objects.create(
                    user=user,
                    department=department
                )
                
                messages.success(request, 'Kayıt başarılı! Yönetici onayından sonra giriş yapabilirsiniz.')
                return redirect('sinavtakip:login')
            else:
                messages.error(request, 'Şifreler eşleşmiyor!')
                
        except Exception as e:
            messages.error(request, 'Kayıt sırasında bir hata oluştu!')
            
    departments = Department.objects.all()
    return render(request, 'register.html', {'departments': departments})

@login_required
@require_http_methods(["GET"])
def get_lessons(request):
    if not request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        return JsonResponse({
            'error': 'Bu endpoint sadece AJAX istekleri için kullanılabilir'
        }, status=400)

    try:
        department_user = DepartmentUser.objects.get(user=request.user)
        
        lesson_ids = LessonDepartment.objects.filter(
            department=department_user.department
        ).values_list('lesson_id', flat=True)
        
        lessons = Lesson.objects.filter(
            id__in=lesson_ids,
        ).order_by('name')
        
        lessons_data = []
        for lesson in lessons:
            lessons_data.append({
                'id': lesson.id,
                'name': lesson.name
            })
        
        if not lessons_data:
            return JsonResponse({
                'lessons': [],
                'message': 'Müsait ders bulunmamaktadır.'
            })

        return JsonResponse({
            'lessons': lessons_data
        })
        
    except DepartmentUser.DoesNotExist:
        return JsonResponse({
            'error': 'Kullanıcı bölüm bilgisi bulunamadı'
        }, status=404)
    except Exception as e:
        return JsonResponse({
            'error': 'Dersler alınırken bir hata oluştu'
        }, status=500)

@login_required
def programlar(request):
    if not request.user.is_approved:
        messages.warning(request, 'Bu sayfaya erişmek için hesabınızın onaylanması gerekmektedir.')
        return redirect('sinavtakip:index')
    
    search_query = request.GET.get('search', '')
    
    departments = Department.objects.all()
    
    if search_query:
        departments = departments.filter(name__icontains=search_query)
    
    departments = departments.order_by('name')
    
    return render(request, 'programlar.html', {
        'departments': departments,
        'search_query': search_query
    })

@staff_member_required
def program_ekle(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        if name:
            try:
                department = Department.objects.create(name=name)
                
                log = ProcessLog(
                    user=request.user,
                    process_type=ProcessType.CREATE,
                    description=f'{name} programı oluşturuldu.'
                )
                log.save()
                
                messages.success(request, f'{name} programı başarıyla eklendi.')
            except Exception as e:
                messages.error(request, f'Program eklenirken bir hata oluştu: {str(e)}')
        else:
            messages.error(request, 'Program adı boş olamaz.')
    return redirect('sinavtakip:programlar')

@staff_member_required
def program_sil(request, program_id):
    if request.method == 'POST':
        try:
            department = get_object_or_404(Department, id=program_id)
            name = department.name
            
            if LessonDepartment.objects.filter(department=department).exists():
                messages.error(request, f'{name} programına atanmış dersler olduğu için silinemez.')
                return redirect('sinavtakip:programlar')
                
            if DepartmentUser.objects.filter(department=department).exists():
                messages.error(request, f'{name} programına atanmış kullanıcılar olduğu için silinemez.')
                return redirect('sinavtakip:programlar')
            
            department.delete()
            
            log = ProcessLog(
                user=request.user,
                process_type=ProcessType.DELETE,
                description=f'{name} programı silindi.'
            )
            log.save()
            
            messages.success(request, f'{name} programı başarıyla silindi.')
        except Exception as e:
            messages.error(request, f'Program silinirken bir hata oluştu: {str(e)}')
    return redirect('sinavtakip:programlar')

@staff_member_required
def loglar(request):
    username = request.GET.get('username')
    process_type = request.GET.get('process_type')
    
    logs_query = ProcessLog.objects.all().select_related('user').order_by('-process_time')
    
    if username:
        logs_query = logs_query.filter(user__username__icontains=username)
    if process_type:
        logs_query = logs_query.filter(process_type=process_type)
    
    paginator = Paginator(logs_query, 20)  
    page = request.GET.get('page')
    
    try:
        logs = paginator.page(page)
    except PageNotAnInteger:
        logs = paginator.page(1)
    except EmptyPage:
        logs = paginator.page(paginator.num_pages)
    
    process_types = [(choice[0], choice[1]) for choice in ProcessType.choices]
    
    context = {
        'logs': logs,
        'process_types': process_types,
    }
    
    return render(request, 'loglar.html', context)

@login_required
@require_http_methods(["POST"])
def set_admin(request, user_id):
    if not request.user.is_staff:
        messages.error(request, 'Bu işlem için yetkiniz bulunmamaktadır.')
        return redirect('sinavtakip:kullanicilar')

    if request.user.id == user_id:
        messages.error(request, 'Kendinize yönetici yetkisi veremez veya kaldıramazsınız.')
        return redirect('sinavtakip:kullanicilar')

    try:
        user = get_object_or_404(User, id=user_id)
        user.is_staff = not user.is_staff
        user.save()

        action = "yönetici yapıldı" if user.is_staff else "yönetici yetkisi kaldırıldı"
        ProcessLog.objects.create(
            user=request.user,
            process_type=ProcessType.UPDATE,
            process_time=timezone.now(),
            description=f"'{user.username}' kullanıcısı '{request.user}' tarafından {action}"
        )

        messages.success(request, f'{user.username} kullanıcısı başarıyla {action}')
    except Exception as e:
        messages.error(request, 'Kullanıcı yetki işlemi yapılırken bir hata oluştu.')

    return redirect('sinavtakip:kullanicilar')

@login_required
@staff_member_required
def ozellikler(request):
    search_query = request.GET.get('search', '')
    
    features = Feature.objects.all()
    
    if search_query:
        features = features.filter(name__icontains=search_query)
    
    features = features.order_by('name')
    
    return render(request, 'ozellikler.html', {
        'features': features,
        'search_query': search_query
    })

@login_required
@staff_member_required
@require_http_methods(["POST"])
def ozellik_ekle(request):
    name = request.POST.get('name')
    
    try:
        with transaction.atomic():
            if not name:
                messages.warning(request, 'Özellik adı boş olamaz.')
                return redirect('sinavtakip:ozellikler')
                
            feature = Feature.objects.create(
                name=name,
                created_date=timezone.now()
            )
            
            ProcessLog.objects.create(
                user=request.user,
                process_type=ProcessType.CREATE,
                process_time=timezone.now(),
                description=f"'{name}' isimli özellik '{request.user}' tarafından eklendi.",
            )
            
            messages.success(request, 'Özellik başarıyla eklendi.')
    except Exception as e:
        messages.error(request, 'Özellik eklenirken bir hata oluştu.')
    
    return redirect('sinavtakip:ozellikler')

@login_required
@staff_member_required
@require_http_methods(["POST"])
def ozellik_sil(request, feature_id):
    try:
        with transaction.atomic():
            feature = get_object_or_404(Feature, pk=feature_id)
            feature_name = feature.name
            
            if ClassroomFeature.objects.filter(feature=feature).exists():
                messages.error(request, f"'{feature_name}' özelliği dersliklerde kullanıldığı için silinemiyor.")
                return redirect('sinavtakip:ozellikler')
            
            feature.delete()
            
            ProcessLog.objects.create(
                user=request.user,
                process_type=ProcessType.DELETE,
                process_time=timezone.now(),
                description=f"'{feature_name}' isimli özellik '{request.user}' tarafından silindi.",
            )
            
            messages.success(request, 'Özellik başarıyla silindi.')
    except Exception as e:
        messages.error(request, 'Özellik silinirken bir hata oluştu.')
    
    return redirect('sinavtakip:ozellikler')