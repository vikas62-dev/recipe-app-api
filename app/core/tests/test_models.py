"""
Tests for models.
"""
# Testcase is the base class for the tests.
from django.test import TestCase
from django.contrib.auth import get_user_model
"""
get_user_model is a helper function provided by django to get the default
user model of the project.
"""


class ModelTests(TestCase):
    """Test models."""

    def test_create_user_with_email_successful(self):
        """Test creating a user with an email is successful."""

        """The Domain name @example.com is a reserved domain name which is
        specifically used for testing purposes. """

        email = 'test@example.com'
        password = 'testpass123'
        user = get_user_model().objects.create_user(
            email=email,
            password=password,
        )

        self.assertEqual(user.email, email)
        # user.check_password is used to check the hashed value of the password
        self.assertTrue(user.check_password(password))
