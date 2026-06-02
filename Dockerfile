FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


RUN python -c "import easyocr; reader = easyocr.Reader(['en'])"



COPY . .

RUN python train_allergen_model.py


EXPOSE 8080


CMD ["streamlit", "run", "UI_Design.py", "--server.port=8080", "--server.address=0.0.0.0"]
