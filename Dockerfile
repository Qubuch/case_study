# Wrong version has been used. 3 instead of 2 according to the code. 
# code should be refactored cause ver 2.7 has been deprecated and its not support any more
# so insted of: FROM python:3
FROM python:2
 
# if this would be a web application we could consider EXPOSING a port
# also adding some paramters for
# not generating .pyc files in the container
 
# ENV PYTHONDONTWRITEBYTECODE=1
 
# and turning off buffering for easier container logging
# ENV PYTHONUNBUFFERED=1
 
# missing setting a WORKDIR to not be in a root
WORKDIR /usr/src/app
 
# RUN pip install flask - its not used in python script so its not needed here. 
# if there would be something to add then the requirements.txt file should be used as follow
# Install pip requirements
# COPY src/requirements.txt .
# RUN python -m pip install --no-cache-dir -r requirements.txt
 
# copying to the working directory as stated in a previous line
COPY magic_ball.py .
 
# can also be switched to non-root user
RUN useradd appuser && chown -R appuser /usr/src/app
USER appuser
 
# if it would be a flask app we can use gunicorn as follows - CMD ["gunicorn", "--bind", "0.0.0.0:5000", "wsgi:app"]
CMD [ "python", "./magic_ball.py" ]