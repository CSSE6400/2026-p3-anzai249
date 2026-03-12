FROM python:3.13-slim 
 
# Installing dependencies for running a Python application 
RUN apt-get update && apt-get install -y pipx 
RUN pipx ensurepath 
 
# Install poetry 
RUN pipx install poetry 
 
# Setting the working directory 
WORKDIR /app 
 
# Install poetry dependencies 
COPY pyproject.toml ./ 
RUN pipx run poetry install --no-root 
 
# Copying our application into the container 
COPY todo todo 
 
# Exposing the port our application will run on 
EXPOSE 6400

# Running our application 
CMD ["pipx", "run", "poetry run flask --app todo run \ 
   --host 0.0.0.0 --port 6400"]