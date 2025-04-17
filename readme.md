# Story Stream Docker

Этот репозиторий содержит конфигурацию для запуска сервисов Story Stream с использованием `docker-compose`.

## Репозитории проекта

- Frontend: https://github.com/IvanMonichev/story-stream-frontend
- Backend: https://github.com/IvanMonichev/story-stream-backend

## Описание сервисов

### PostgreSQL

СУБД PostgreSQL используется как основная база данных.

- Образ: `postgres:15`
- Порт: `5435` (хост) → `5432` (контейнер)
- Переменные окружения загружаются из `.env`
- Данные сохраняются в volume `postgres_data`

### pgAdmin

Веб-интерфейс для управления PostgreSQL.

- Образ: `dpage/pgadmin4`
- Порт: `5445` (хост) → `80` (контейнер)
- Переменные окружения загружаются из `.env`
- Использует volume `pgadmin_data`
- Зависит от сервиса `postgres`

### Portainer

Веб-интерфейс для управления Docker.

- Образ: `portainer/portainer-ce:latest`
- Порт: `9000`
- Использует volume `portainer_data` для хранения данных
- Подключается к Docker через сокет `/var/run/docker.sock`

### Story Stream Frontend

Клиентская часть приложения Story Stream.

- Образ: `ivanmonichev/story-stream-frontend:latest`
- Порт: `3000` (хост) → `8080` (контейнер)

### Story Stream Backend

Серверная часть приложения Story Stream.

- Образ: `tatarjesus/story-stream-backend:latest`
- Порт: `8810` (хост) → `8810` (контейнер)

### Nginx

Обратный прокси для frontend.

- Образ: `nginx:latest`
- Порты: `80`, `443`
- Использует конфигурацию `./nginx/default.conf`
- Зависит от `story-stream-frontend`

## Запуск

1. Создайте файл `.env` на основе переменных, требуемых PostgreSQL и pgAdmin:
```env
   POSTGRES_USER=your_user
   POSTGRES_PASSWORD=your_password
   POSTGRES_DB=your_db
   PGADMIN_DEFAULT_EMAIL=admin@example.com
   PGADMIN_DEFAULT_PASSWORD=admin
```

2. Запустите все сервисы:
```bash
docker-compose up -d
```

3.Проверьте доступность:

- Frontend: http://localhost:3000
- pgAdmin: http://localhost:5445
- Portainer: http://localhost:9000

