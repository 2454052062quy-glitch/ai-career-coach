<!-- SPDX-License-Identifier: MIT -->
# AI Career Coach

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Data: CC BY 4.0](https://img.shields.io/badge/Data-CC_BY_4.0-green.svg)](data/LICENSE)

> 🇻🇳 **Phiên bản tiếng Việt:** [README.md](README.md)

An AI career advisor and interview coach that **personalizes guidance to each student's interests and experience**. It runs entirely on your own machine through [Ollama](https://ollama.com): open source, no API key required, and your profile never leaves your computer.

Built by team **TQL** for the *Open-Source Application Development* contest (Track 3), Faculty of Information Technology, Ho Chi Minh City Open University, 2026.

![Demo](docs/images/demo.gif)

## Features

- **Personal profile:** skills (levels 1–5), interests by topic, and experience (projects, internships, clubs, competitions). Upload a CV to auto-fill.
- **Skill gap analysis:** compares your profile against a built-in role or a job description (JD) you paste in. The match score covers skills, interests and experience, with a written explanation.
- **Weekly learning plan:** schedules small 15–30 minute tasks into your free slots, targeting your weak spots.
- **Daily tasks and streaks:** helps you build a steady study habit.
- **Weekly report:** shows actual study hours, completed tasks and skill progress, then asks for next week's availability and re-plans.
- **Interview question bank:** standard questions for the role plus questions based on your own projects. Answer first, then view the suggested answer.

## How it works

1. **Enter your profile:** add skills, interests and experience, or upload a CV to fill them in.
2. **Pick a target:** choose a built-in role or paste the JD of a job you care about.
3. **Gap analysis:** a locally running AI model compares your profile with the requirements, computes a match score and explains the reasoning in plain text.
4. **Plan:** the app breaks weak areas into 15–30 minute tasks and fits them into your free time.
5. **Track and adjust:** do tasks daily, review the weekly report, and re-plan for the following week.

Everything is processed on your machine; no data is sent to external services.

## System requirements

- Option 1 (recommended): [Docker](https://docs.docker.com/get-docker/) with Docker Compose v2.
- Option 2 (no Docker): Python 3.11+, PostgreSQL 16 and Ollama installed.
- RAM: a 7B-parameter model needs about 8 GB of RAM or more; on weaker machines choose a smaller model (see Configuration).
- Free disk space: about 10 GB (Docker images and models).

## Quick start with Docker

```bash
git clone https://github.com/tql-team/ai-career-coach.git
cd ai-career-coach
cp .env.example .env        # change the password and model if needed
make docker-up              # or: docker compose up --build -d
make pull-model             # first-time Ollama model download (several GB, needs internet)
```

Open <http://localhost:8000> in your browser.

Auto-generated API docs (Swagger UI): <http://localhost:8000/docs>

Stop the app: `make docker-down`.

## Install without Docker

```bash
git clone https://github.com/tql-team/ai-career-coach.git
cd ai-career-coach
make install                # creates a .venv virtual environment and installs dependencies
cp .env.example .env        # set DATABASE_URL and OLLAMA_URL for your machine
ollama pull mistral         # or your chosen model (must match OLLAMA_MODEL in .env)
make run
```

PostgreSQL must be running, with a database matching `DATABASE_URL` already created.

## Configuration

Everything lives in the `.env` file (template in `.env.example`):

| Variable | Meaning |
|---|---|
| `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB` | PostgreSQL credentials |
| `DATABASE_URL` | Connection string when running without Docker |
| `OLLAMA_URL` | Address of the Ollama server |
| `OLLAMA_MODEL` | Ollama model name to use (e.g. `mistral`) |
| `APP_PORT` | Application port (default 8000) |

Choosing a model: try a few models with real Vietnamese sentences on your weakest machine, and **read each model's license** on its model page before use, since many models have their own terms.

## Useful commands

Run `make help` for the full list.

| Command | Purpose |
|---|---|
| `make install` | Create the virtual environment and install dependencies |
| `make run` | Run the app |
| `make test` | Run the tests |
| `make lint` | Check code style |
| `make docker-up` / `make docker-down` | Start / stop with Docker |
| `make pull-model` | Download the Ollama model |

## Project structure

```
app/            application source code (FastAPI)
data/           skill catalog, career roles, sample data
docs/           setup, architecture and roadmap documentation
tests/          tests
Dockerfile      application image
docker-compose.yml   runs the app, PostgreSQL and Ollama together
Makefile        common commands
```

## Data and privacy

- Profiles and CVs are processed locally and never sent to external services.
- Career role data is written by the team; sample students and CVs are fictional.
- AI-generated results are for reference only.

## License

- **Source code:** [MIT](LICENSE).
- **Data in `data/`:** [Creative Commons Attribution 4.0 (CC BY 4.0)](data/LICENSE).
- Third-party libraries, models and data, along with their licenses, are listed in [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md). Models run through Ollama carry their own individual licenses.

## Contributing and contact

Contributions are very welcome, including new career roles or interview questions in the `data/` folder. See [CONTRIBUTING.md](CONTRIBUTING.md).

- Bug reports and feature requests: <https://github.com/tql-team/ai-career-coach/issues>
- Questions and discussion: <https://github.com/tql-team/ai-career-coach/discussions>

## Team

Team TQL: Ngọc Thạch, Thục Linh, Tấn Quý.
