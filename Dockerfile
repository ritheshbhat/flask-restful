FROM python:3.9.2-slim-buster AS compile-image

RUN apt-get update -y && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends build-essential python3-dev libffi-dev libssl-dev \
  && python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
COPY requirements.txt /tmp/
COPY dist/wisecoder-0.0.1.tar.gz /tmp
COPY src/wisecoder/version.txt /tmp
RUN pip install --upgrade pip setuptools wheel && pip install -r /tmp/requirements.txt
RUN pip install /tmp/wisecoder-0.0.1.tar.gz



FROM python:3.9.2-slim-buster AS runtime-image
COPY --from=compile-image /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN apt-get update -y && apt-get upgrade -y \
  && apt-get clean -y && apt-get autoclean -y \
  && rm -r /var/cache/apt/*

COPY entrypoint.sh /home
WORKDIR /home
EXPOSE 9095
ENTRYPOINT [ "bash /home/entrypoint.sh", "/opt/venv/bin"]
