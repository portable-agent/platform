# ADR-0004: Temporal для durable action execution

- Status: accepted
- Date: 2026-08-26

## Контекст

Действия могут ждать подтверждения пользователя, восстановления провайдера, назначенного времени или
компенсации. Реализация этих семантик через Kafka consumers и поля статуса в базе создала бы самописный
workflow engine.

## Решение

Action Service владеет Temporal workflows. Kafka остаётся backbone интеграционных событий и не заменяет
состояние workflow. Код workflow должен быть детерминированным; вызовы провайдеров выполняются как Activities.

## Последствия

Платформа получает durable timers, retries, cancellation, versioning, visibility и replay. Temporal
становится эксплуатационной инфраструктурой и требует backup, monitoring, upgrade и runbook-работ.
