from django.urls import path
from . import views

app_name = 'sinavtakip'

urlpatterns = [
    path('', views.index, name='index'),
    path('login/', views.user_login, name='login'),
    path('register/', views.user_register, name='register'),
    path('logout/', views.user_logout, name='logout'),
    path('derslikler/', views.derslikler, name='derslikler'),
    path('taleplerim/', views.taleplerim, name='taleplerim'),
    path('dersler/', views.dersler, name='dersler'),
    path('tum-talepler/', views.tum_talepler, name='tum_talepler'),
    path('get-derslikler/', views.get_derslikler, name='get_derslikler'),
    path('derslik-ekle/', views.derslik_ekle, name='derslik_ekle'),
    path('derslik-sil/<int:classroom_id>/', views.derslik_sil, name='derslik_sil'),
    path('ders-sil/<int:lesson_id>/', views.ders_sil, name='ders_sil'),
    path('ders-ekle/', views.ders_ekle, name='ders_ekle'),
    path('talep-olustur/<int:classroom_id>/<int:lesson_id>/<int:exam_time_id>/', views.talep_olustur, name='talep_olustur'),
    path('talep-iptal/<int:request_id>', views.talep_iptal, name='talep_iptal'),
    path('talep-onayla/<int:request_id>/', views.talep_onayla, name='talep_onayla'),
    path('talep-reddet/<int:request_id>/', views.talep_reddet, name='talep_reddet'),
    path('profil/', views.profil, name='profil'),
    path('get-exam-times/<int:date_id>/<int:classroom_id>/', views.get_exam_times, name='get_exam_times'),
    path('get-lessons/', views.get_lessons, name='get_lessons'),
    path('kullanicilar/', views.kullanicilar_view, name='kullanicilar'),
    path('kullanicilar/activate/<int:user_id>/', views.activate_user, name='activate_user'),
    path('kullanicilar/reject/<int:user_id>/', views.reject_user, name='reject_user'),
    path('kullanicilar/deactivate/<int:user_id>/', views.deactivate_user, name='deactivate_user'),
    path('kullanicilar/set_admin/<int:user_id>/', views.set_admin, name='set_admin'),
    path('programlar/', views.programlar, name='programlar'),
    path('program-ekle/', views.program_ekle, name='program_ekle'),
    path('program-sil/<int:program_id>/', views.program_sil, name='program_sil'),
    path('loglar/', views.loglar, name='loglar'),
    path('ozellikler/', views.ozellikler, name='ozellikler'),
    path('ozellik-ekle/', views.ozellik_ekle, name='ozellik_ekle'),
    path('ozellik-sil/<int:feature_id>/', views.ozellik_sil, name='ozellik_sil'),
]