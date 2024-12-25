from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
from django.db.models.functions import Now

User.add_to_class('is_approved', models.BooleanField(default=False))

class ProcessType(models.TextChoices):
    CREATE = '0', 'Create'
    DELETE = '1', 'Delete'
    UPDATE = '2', 'Update'
    APPROVE = '3', 'Approve'

class ClassroomFeature(models.Model):
    id = models.AutoField(primary_key=True)
    feature = models.ForeignKey('Feature', models.DO_NOTHING, blank=True, null=True)
    classroom = models.ForeignKey('Classroom', models.DO_NOTHING, related_name='features', blank=True, null=True)
    created_date = models.DateTimeField(db_default=Now())

    class Meta:
        managed = True
        db_table = 'ClassFeatureRelation'

    def __str__(self):
        return f"{self.classroom.title} - {self.feature.name}"


class Classroom(models.Model):
    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=255, blank=True, null=True)
    capacity = models.IntegerField(blank=True, null=True)
    created_date = models.DateTimeField(db_default=Now())

    class Meta:
        managed = True
        db_table = 'Classes'

    def __str__(self):
        return self.title


class Department(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=35, blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'Departments'

    def __str__(self):
        return self.name


class Feature(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255, blank=True, null=True)
    created_date = models.DateTimeField(db_default=Now())

    class Meta:
        managed = True
        db_table = 'Features'

    def __str__(self):
        return self.name


class ProcessLog(models.Model):
    id = models.AutoField(primary_key=True)
    user = models.ForeignKey(User, models.DO_NOTHING, blank=True, null=True)
    process_type = models.CharField(
        max_length=50,
        choices=ProcessType.choices,
        default=ProcessType.CREATE
    )
    description = models.CharField(max_length=255, blank=True, null=True)
    process_time = models.DateTimeField(db_default=Now())

    class Meta:
        managed = True
        db_table = 'ProcessLog'

    def __str__(self):
        return f"{self.user} - {self.get_process_type_display()} - {self.process_time}"


class Request(models.Model):
    STATUS_CHOICES = [
        (0, 'Beklemede'),
        (1, 'Onaylandı'),
        (2, 'Reddedildi')
    ]

    id = models.AutoField(primary_key=True)
    user = models.ForeignKey(
        User, 
        models.DO_NOTHING, 
        related_name='requests', 
        null=False  
    )
    classroom = models.ForeignKey(
        'Classroom', 
        models.DO_NOTHING, 
        null=False  
    )
    approved_user = models.ForeignKey(
        User, 
        models.DO_NOTHING, 
        related_name='approved_requests', 
        null=True  
    )
    status = models.IntegerField(
        choices=STATUS_CHOICES, 
        default=0  
    )
    rejection_message = models.TextField(blank=True, null=True)
    request_date = models.DateTimeField(db_default=Now())
    requested_lesson = models.ForeignKey(
        'Lesson', 
        models.DO_NOTHING, 
        null=True  
    )
    exam_time = models.ForeignKey(
        'ExamTime', 
        models.DO_NOTHING, 
        null=True  
    )



    class Meta:
        managed = True
        db_table = 'Requests'

    def __str__(self):
        return f"{self.user} - {self.classroom.title}"


class DepartmentUser(models.Model):
    id = models.AutoField(primary_key=True)
    user = models.ForeignKey(User, models.DO_NOTHING, blank=True, null=True)
    department = models.ForeignKey('Department', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'DepartmentUserRelation'

    def __str__(self):
        return f"{self.user.username} - {self.department.name}"


class Lesson(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=35, blank=True, null=True)
    grade = models.IntegerField(blank=True, null=True)
    term = models.IntegerField(blank=True, null=True)
    created_date = models.DateTimeField(db_default=Now())

    class Meta:
        managed = True
        db_table = 'Lessons'

    def __str__(self):
        return self.name


class LessonDepartment(models.Model):
    id = models.AutoField(primary_key=True)
    department = models.ForeignKey('Department', models.DO_NOTHING, blank=True, null=True)
    lesson = models.ForeignKey('Lesson', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = True
        db_table = 'LessonDepartmentRel'

    def __str__(self):
        return f"{self.department} - {self.lesson}"


class ExamDate(models.Model):
    id = models.AutoField(primary_key=True)
    date = models.DateField(unique=True)

    class Meta:
        managed = True
        db_table = 'exam_dates'
        verbose_name = 'Exam Date'
        verbose_name_plural = 'Exam Dates'

    def __str__(self):
        return str(self.date)


class ExamTime(models.Model):
    id = models.AutoField(primary_key=True)
    date = models.ForeignKey(
        'ExamDate',
        on_delete=models.CASCADE,
        related_name='exam_times',
        null=True  
    )
    time_slot = models.CharField(max_length=11)

    class Meta:
        managed = True
        db_table = 'exam_times'
        indexes = [
            models.Index(fields=['date']),
        ]
        verbose_name = 'Exam Time'
        verbose_name_plural = 'Exam Times'

    def __str__(self):
        return f"{self.date} - {self.time_slot}"


class ClassroomExamTime(models.Model):
    classroom = models.ForeignKey(Classroom, on_delete=models.CASCADE)
    exam_time = models.ForeignKey(ExamTime, on_delete=models.CASCADE)
    is_available = models.BooleanField(default=True)
    created_date = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ['classroom', 'exam_time']
        db_table = 'ClassRoomExamTime'

    def __str__(self):
        return f"{self.classroom.title} - {self.exam_time.time_slot}"
