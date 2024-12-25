from django.contrib import admin
from .models import (
    Classroom, Feature, ClassroomFeature,
    Department, DepartmentUser, ProcessLog,
    Lesson, LessonDepartment, ExamDate, ExamTime
)

admin.site.register(Classroom)
admin.site.register(Feature)
admin.site.register(ClassroomFeature)
admin.site.register(Department)
admin.site.register(DepartmentUser)
admin.site.register(ProcessLog)
admin.site.register(Lesson)
admin.site.register(LessonDepartment)
admin.site.register(ExamDate)
admin.site.register(ExamTime)
