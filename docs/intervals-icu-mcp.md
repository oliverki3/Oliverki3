# Intervals.icu MCP Connector

Gibt Claude (Code/Desktop) lesenden und schreibenden Zugriff auf deine
Trainingsdaten via [Intervals.icu](https://intervals.icu) — inklusive der
Garmin-Aktivitäten, die dort bereits synchronisiert werden.

## Wichtig: kein direkter Garmin-Zugriff

Dieser MCP-Server spricht ausschließlich mit der Intervals.icu-API. Garmin-Daten
sind nur erreichbar, wenn dein Garmin-Connect-Konto bereits mit Intervals.icu
verknüpft ist (Intervals.icu → Settings → Connections). Das ist ein einmaliger
manueller Schritt auf intervals.icu, den dieser Connector nicht übernimmt.

## Was der Server bereitstellt

~48 Tools in 9 Kategorien: Activities, Activity Analysis, Athlete, Wellness,
Events/Calendar, Performance/Curves, Workout Library, Gear Management, Sport
Settings. Lesen dominiert, aber Update/Create/Delete sind für Activities,
Wellness, Events, Gear und Settings enthalten.

Quelle: [eddmann/intervals-icu-mcp](https://github.com/eddmann/intervals-icu-mcp)
(MIT). Alternative mit zusätzlichen Bugfixes/Features und PyPI-Release:
[hhopke/intervals-icu-mcp](https://github.com/hhopke/intervals-icu-mcp)
(`pip install intervals-icu-mcp` / `uvx intervals-icu-mcp`).

## Setup (einmalig, lokal)

Voraussetzung: [uv](https://docs.astral.sh/uv/) und Python 3.11+.

```bash
./scripts/setup-intervals-icu-mcp.sh
```

Das Script klont `eddmann/intervals-icu-mcp` als Sibling-Verzeichnis neben
diesem Repo (`../intervals-icu-mcp`) und installiert die Abhängigkeiten. Danach:

1. API-Key holen: intervals.icu → Settings → Developer Settings.
2. Athlete-ID ist das `iNNNNNN` aus deiner Profil-URL.
3. Beides als Umgebungsvariablen in deinem Shell-Profil setzen (**niemals
   committen**):

   ```bash
   export INTERVALS_ICU_API_KEY="dein_api_key"
   export INTERVALS_ICU_ATHLETE_ID="i123456"
   ```

4. Shell neu laden, Claude Code in diesem Repo (neu) öffnen. Der Server
   `intervals-icu` aus [`.mcp.json`](../.mcp.json) startet automatisch.

## Sicherheits-Hinweis zu Delete-Operationen

Der Server unterstützt `INTERVALS_ICU_DELETE_MODE` (`safe` / `full` / `none`,
Default `safe`). `safe` verhindert versehentliches Löschen von Aktivitäten/
Events. Nur auf `full` stellen, wenn uneingeschränkter Schreib-/Löschzugriff
bewusst gewollt ist — z. B. zusätzlich in `.mcp.json` unter `env` setzen:

```json
"INTERVALS_ICU_DELETE_MODE": "full"
```

## Andere Wege (nicht Teil dieses Setups)

Für Claude **Desktop** statt Claude Code gilt dasselbe Prinzip, aber die
Konfiguration liegt in `claude_desktop_config.json`
(macOS: `~/Library/Application Support/Claude/`, Windows: `%APPDATA%\Claude\`)
statt in `.mcp.json` — dort denselben `command`/`args`/`env`-Block eintragen.
