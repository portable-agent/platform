# Диагностика документации

## Базовая проверка

Из корня репозитория:

```powershell
pwsh ./scripts/check-docs.ps1
```

## Публичный сайт

```bash
cd website
pnpm install --frozen-lockfile
pnpm typecheck
pnpm build
```

Сборка Docusaurus останавливается при битой внутренней ссылке. Исправьте ссылку или имя файла, не отключая
строгий режим.

## Карточка Backstage не читается

Проверьте в `catalog-info.yaml`:

- `apiVersion`, `kind`, `metadata.name` и `spec.owner`;
- `backstage.io/techdocs-ref: dir:.`;
- правильный `github.com/project-slug`.

Backstage пока не является runtime-частью платформы. Ошибка каталога не влияет на работу сервисов.
