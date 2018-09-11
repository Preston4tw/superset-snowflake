# docker build -t superset .
# docker run -d -p 8088:8088 --name superset superset
# snowflake://<username>:<password>@<account>/<database>/<schema>?role=<role>&warehouse=<warehouse>
FROM python:3.6

RUN apt-get update && apt-get -y install build-essential libssl-dev libffi-dev python-dev python-pip libsasl2-dev libldap2-dev
RUN pip install superset snowflake-sqlalchemy \
 && fabmanager create-admin --app superset --username admin --firstname admin --lastname admin --email admin@127.0.0.1 --password admin \
 && superset db upgrade \
 && superset init

EXPOSE 8088
CMD superset runserver -d -a 0.0.0.0
