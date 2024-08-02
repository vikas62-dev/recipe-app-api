"""
Database models.
"""
# noqa means it will tell the flake8 to ignore this error
from django.db import models    # noqa

from django.contrib.auth.models import (
    AbstractBaseUser,
    BaseUserManager,
    PermissionsMixin,
)
# Create your models here.


class UserManager(BaseUserManager):
    """Manager for users."""

    def create_user(self, email, password=None, **extra_fields):
        """Create, save and return a new user."""
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)

        return user


"""
AbstractBaseUser contains the functionality for the authentication system
but any fields.
PermissionsMixin contains the functionality for the permissions feature of
Django, and it also contains any fields that are needed for permissions feature
"""


class User(AbstractBaseUser, PermissionsMixin):
    """User in the system."""
    email = models.EmailField(max_length=255, unique=True)
    name = models.CharField(max_length=255)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)

    objects = UserManager()

    """
    USERNAME_FIELD here which defines the field that we want to use for
    authentication. and this is how we replace the username default field that
    comes with the default user model to our custom email field.
    """
    USERNAME_FIELD = 'email'
