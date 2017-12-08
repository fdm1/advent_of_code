FROM python:3.6.2

WORKDIR /code_advent
COPY requirements.txt .
COPY setup.py .
COPY code_advent/ code_advent
RUN pip install -e .

CMD ["bash", "-c", 'while true; do sleep 5; done']
