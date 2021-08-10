# build python environment

FROM python:3.8-slim
# it seems we no longer need any compilers.. yay
RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential gcc

RUN python -m venv /opt/venv
# Make sure we use the virtualenv:
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install -I pip
RUN pip install -r requirements.txt

# build app container
FROM python:3.8-slim
COPY --from=0 /opt/venv /opt/venv

# Copy essential files to the app folder
WORKDIR /app
COPY server.py .

ENV PATH="/opt/venv/bin:$PATH"
EXPOSE 8080
CMD ["python", "server.py"]
