# mCore

### Disclaimer

#### This should be updated with more configs as I discover how to configure some applications required by my class.

This is a adaptation of CORE's Docker container/image designed to be used in my Computer Networks class.

## Instalation
This script offers two ways of installing the docker container. The "Easy Way" and a "Git Way".

### Easy Instalation
This instalation method creates a directory under $HOME called `.mCore` where the git repository will be stored. You can delete this directory after the install.
```sh
curl -sSL http://mayorx.xyz/.scripts/install_mcore.sh | sh"
```

### Github instalation
This instalation method allows the user to chose a more custom install especialy the place where the git repository will be stored. This directory can be deleted after the install.
```sh

# Clone the repository
git clone https://github.com/MayorX500/mCore.git

# Cd into the directory
cd mCore/

# Install the docker container
sudo --preserve-env=HOME make install

```

## Usage

The script automaticaly creates the required executables.
in the user's /usr/local/bin called core-gui and a Desktop entry in $HOME/.local/share/applications called core.desktop.
```sh
core-gui	# Run the CORE from the shell
core-bash 	# Run the DOCKER shell from the HOST

```


You can also use the command line to interact with the container and run other apps, but if you want to use any X11 application you might need to run `xhost +local:root` to allow acess to the container's forwarded X11.  


## Uninstallation

```sh
# Open a terminal and run
core-uninstall

```

or if the repo is still on the device
```sh
# Go to the git repo and run
sudo make uninstall

```

or run this curl if the repo is no longer on the device
```sh
wget https://raw.githubusercontent.com/MayorX500/mCore/master/makefile && sudo make uninstall

```


### License (CORE)

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
