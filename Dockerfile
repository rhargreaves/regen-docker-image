FROM base/devel
RUN useradd --create-home -s /bin/bash regen && \
	passwd -d regen
RUN printf 'regen ALL=(ALL) ALL\n' | tee -a /etc/sudoers
RUN printf '[multilib]\nInclude = /etc/pacman.d/mirrorlist\n' | tee -a /etc/pacman.conf && \
	pacman-db-upgrade && \
	pacman -Syyu --noconfirm && \
	pacman -S --noconfirm git sudo && \
	pacman -Ss --noconfirm font
USER regen
WORKDIR /home/regen
RUN git clone https://aur.archlinux.org/libffi5.git && \
	cd libffi5 && \
	makepkg -si --noconfirm && \
	cd .. && \
	rm -rf libffi5 && \
	git clone https://aur.archlinux.org/lib32-libffi5.git && \
	cd lib32-libffi5 && \
	(yes | makepkg -si) && \
	cd .. && \
	rm -rf lib32-libffi5 && \
	git clone https://aur.archlinux.org/regen.git && \
	cd regen && \
	makepkg -si --noconfirm && \
	cd .. && \
	rm -rf regen && \
	git clone https://aur.archlinux.org/ttf-ms-fonts.git && \
	cd ttf-ms-fonts && \
	makepkg -si --noconfirm && \
	cd .. && \
	rm -rf ttf-ms-fonts
ENTRYPOINT ["regen"]
