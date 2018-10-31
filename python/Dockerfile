FROM python:3.7.0

WORKDIR /code_advent
COPY test-requirements.txt .
RUN pip install -r test-requirements.txt

COPY . .
RUN pip install -e .

CMD ["/bin/bash", "-c", "while true; do sleep 5; done"]