# Выполнение действия

Ниже приведена исполняемая документация: Mermaid отображает её в pull request и публичном портале.

```mermaid
sequenceDiagram
    autonumber
    actor User as Пользователь
    participant Channel as Telegram adapter
    participant Gateway as Channel Gateway
    participant Conversation as Conversation Service
    participant Agent as Agent Runtime
    participant Action as Action Service
    participant Policy as OPA
    participant Approval as Approval Service
    participant Temporal as Temporal Workflow
    participant MCP as MCP Gateway
    participant Calendar as Calendar MCP
    participant Audit as Audit Service

    User->>Channel: Голосовая команда
    Channel->>Gateway: Normalized message and audio reference
    Gateway->>Conversation: Accept message
    Conversation->>Agent: Interpret intent with scoped context
    Agent-->>Action: ProposedAction with typed arguments
    Action->>Action: Persist immutable payload and hash
    Action->>Policy: Evaluate actor, action, resource, context
    Policy-->>Action: REQUIRE_APPROVAL
    Action->>Approval: Create one-time approval for payload hash
    Approval-->>Channel: Render confirmation widget
    User->>Channel: Confirm
    Channel->>Approval: Approval token
    Approval->>Temporal: Start workflow with approved action ID
    Temporal->>MCP: Execute tool with idempotency key
    MCP->>Calendar: Create calendar event
    Calendar-->>MCP: Provider resource ID
    MCP-->>Temporal: Tool result
    Temporal-->>Action: Action completed
    Action-->>Audit: ActionCompleted event
    Action-->>Channel: Result widget
```

После подтверждения модель не вызывается повторно для генерации аргументов инструмента. Temporal получает
сохранённый action ID, а executor проверяет payload hash перед вызовом инструмента.
