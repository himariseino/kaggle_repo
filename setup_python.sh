#!/usr/bin/env bash

set -euo pipefail

PYTHON_VERSION="3.12.1"

install_pyenv() {
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
}

setup_python() {
    install_pyenv
    if ! pyenv versions | grep "${PYTHON_VERSION}"; then
        echo "Installing Python ${PYTHON_VERSION}..."
        pyenv install ${PYTHON_VERSION}
    else
        echo "Python ${PYTHON_VERSION} is already installed."
    fi
    echo "Setting local Python version to ${PYTHON_VERSION}..."
    pyenv local ${PYTHON_VERSION}
    echo "Python ${PYTHON_VERSION} setup complete."
}

install_poetry() {
    if command -v poetry &> /dev/null; then
        echo "poetry is already installed."
    else
        echo "Installing poetry..."
        curl -sSL https://install.python-poetry.org | python3 -
        
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
        source ~/.bashrc
        echo "poetry installation complete. Please restart your terminal or run 'source ~/.bashrc' to apply changes."
    fi
}

init_poetry_project() {
    setup_python
    install_poetry
    if [ ! -f "pyproject.toml" ]; then
        echo "Initializing new poetry project..."
        poetry init -n
        poetry add --group dev pytest ruff mypy
        poetry add --group demo ipykernel plotly 
    else
        echo "Poetry project already initialized. Updating dependencies..."
        poetry update
    fi
    poetry env use "${PYTHON_VERSION}"
    poetry config virtualenvs.in-project true
    echo "Poetry project setup complete with virtual environment in project directory."
}

setup_python_project() {
    init_poetry_project
    echo "All setup tasks completed successfully."
}

show_python_version() {
    echo "Current Python version: ${PYTHON_VERSION}"
}

show_poetry_config() {
    poetry config --list
}

# Main execution
setup_python_project
show_python_version
show_poetry_config