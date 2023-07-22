FROM python:3.11

ADD . /code
WORKDIR /code

RUN apt-get update 
RUN pip install -r requirements.txt

EXPOSE 5000
CMD ["python", "app.py"]