FROM python:3.10-alpine3.15

LABEL MAINTAINER "Sagar Utekar"

RUN pip install --upgrade pip

RUN adduser -D appuser
USER appuser
WORKDIR /home/appuser

ENV PATH="/home/appuser/.local/bin:${PATH}"

COPY --chown=appuser:appuser requirements.txt requirements.txt
RUN pip install --user -r requirements.txt

COPY --chown=appuser:appuser . .

CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
