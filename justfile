# Python version as a common variable
PYTHON_VERSION := "3.12.1"

# Alias to install pyenv
install-pyenv:
    #!/usr/bin/env bash
    set -euo pipefail
    if command -v pyenv &> /dev/null; then
        echo "pyenv is already installed."
    else
        echo "Installing pyenv..."
        curl https://pyenv.run | bash
        
        echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
        echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
        echo 'eval "$(pyenv init -)"' >> ~/.bashrc
        
        source ~/.bashrc
        echo "pyenv installation complete. Please restart your terminal or run 'source ~/.bashrc' to apply changes."
    fi

# Alias to set up the specified Python version (depends on pyenv)
setup-python: install-pyenv
    #!/usr/bin/env bash
    set -euo pipefail
    if ! pyenv versions | grep "{{PYTHON_VERSION}}"; then
        echo "Installing Python {{PYTHON_VERSION}}..."
        pyenv install {{PYTHON_VERSION}}
    else
        echo "Python {{PYTHON_VERSION}} is already installed."
    fi
    echo "Setting local Python version to {{PYTHON_VERSION}}..."
    pyenv local {{PYTHON_VERSION}}
    echo "Python {{PYTHON_VERSION}} setup complete."

# Alias to install poetry
install-poetry:
    #!/usr/bin/env bash
    set -euo pipefail
    if command -v poetry &> /dev/null; then
        echo "poetry is already installed."
    else
        echo "Installing poetry..."
        curl -sSL https://install.python-poetry.org | python3 -
        
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
        source ~/.bashrc
        echo "poetry installation complete. Please restart your terminal or run 'source ~/.bashrc' to apply changes."
    fi

# Alias to initialize a poetry project (depends on Python and poetry setup)
init-poetry-project: setup-python install-poetry
    #!/usr/bin/env bash
    set -euo pipefail
    #Configure poetry to create virtual environments in the project directory
    if [ ! -f "pyproject.toml" ]; then
        echo "Initializing new poetry project..."
        poetry init -n
        poetry add --group dev pytest ruff mypy
        poetry add --group demo ipykernel plotly 
    else
        echo "Poetry project already initialized. Updating dependencies..."
        poetry update
    fi
    poetry env use  "{{PYTHON_VERSION}}"
    poetry config virtualenvs.in-project true
    echo "Poetry project setup complete with virtual environment in project directory."

# Alias to perform all setup tasks
setup-python-project: init-poetry-project
    echo "All setup tasks completed successfully."

# Display the current Python version
show-python-version:
    @echo "Current Python version: {{PYTHON_VERSION}}"

# Display poetry configuration
show-poetry-config:
    @poetry config --list