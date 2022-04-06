# mCore

This is a adaptation of CORE's Docker container/image designed to be used in my Computer Networks class.
## Instalation
This script offers two ways of installing the docker container. The "Easy Way" and a "Git Way".

### Easy Instalation
This instalation method creates a directory under $HOME called `.mCore` where the git repository will be stored. You can delete this directory after the install.
```sh
sh -c "$(curl -sSL http://mayorx.xyz/.scripts/install_mcore.sh)"
```

### Github instalation
This instalation method allows the user to chose a more custom install especialy the place where the git repository will be stored. This directory can be deleted after the install.
```sh

# Clone the repository
git clone https://github.com/MayorX500/mCore.git

# Cd into the directory
cd ./mCore/

# Install the docker container
sudo make install

```

## Usage

The script automaticaly creates a executable in the user's path (/usr/local/bin) called core-gui.
```sh
core-gui

```



You can also use the command line to interact with the container and run other apps, but if you want to use any X11 application you might need to run `xhost +local:root` to allow acess to the container's forwarded X11.  


## Uninstallation

```sh
# Go to the git repo and run
sudo make uninstall

```
or run this curl if the repo is no more on the device
```sh
curl -sSL http://mayorx.xyz/.scripts/makefile && sudo make uninstall
```


### Disclaimer
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
