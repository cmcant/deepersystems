# Generated by Django 2.0.8 on 2019-10-30 11:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0002_remove_picture_deleted_at'),
    ]

    operations = [
        migrations.AddField(
            model_name='picture',
            name='url',
            field=models.CharField(blank=True, max_length=400, null=True),
        ),
    ]
