# alpine3.13 is a light weight tags.
FROM python:3.9-alpine3.13
# Maintainer of this website
LABEL maintainer="vikas62dev"  

# To tell python not to buffer the output. print the direct output from python directly to console.
ENV PYTHONUNBUFFERED 1

# Copying the files from our local into the tmp folder of the docker image .
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
# we are setting the current work directory to run all the python code from this directory.
WORKDIR /app
# We are setting a open port 8000 to access our docker image. 
EXPOSE 8000

# We are updating it to True in docker-compose file if it is running in dev server, and default false for all other server.
ARG DEV=false

# Run will run all the commands listed below.
# python -m venv /py                                to install the virtual environment.
# /py/bin/pip install --upgrade pip                 to upgrade the pip installer.
# /py/bin/pip install -r /tmp/requirements.txt      to install the requirements.txt file.
# rm -rf /tmp                                       to remove the tmp folder to keep docker image light weight.
# adduser                                           command to add a new user inside docker image. Because default user is root has full access to avoid risk we add user.
# --disabled-password                               we are disabling the password for logging in.
# --no-create-home                                  we are not create a home directory for this user.
# django-user                                       user name

# This is a shell script, if dev = true, it will run the pip install command. 
# if [ $DEV = "true" ]; \
#     then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
# fi && \

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# We are updateing the path of environment variable to avoid typing /py/bin  everytime we run the commands.      
ENV PATH="/py/bin:$PATH"

# We are switching the user from root to django-user
USER django-user
