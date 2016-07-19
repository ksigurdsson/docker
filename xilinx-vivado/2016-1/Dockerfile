FROM base
RUN apt-get -y update
RUN apt-get install -y nano

# Need xorg to launch gui apps
RUN apt-get install -y xorg

# Upload the source to install Vivado
ADD Xilinx_Vivado_SDK_2016.1_0409_1.tar.gz /install
ADD install_config.txt /install

# Run the installer
RUN cd /install/Xilinx_Vivado_SDK_2016.1_0409_1 \
    && ./xsetup --agree XilinxEULA,3rdPartyEULA,WebTalkTerms --batch Install --config /install/install_config.txt

# Remove the source from the image
#RUN rm -rf /install

ENV PATH=/tools/Xilinx/DocNav:/tools/Xilinx/Vivado/2016.1/bin:/tools/Xilinx/Vivado_HLS/2016.1/bin:$PATH
ENV XILINX_VIVADO=/tools/Xilinx/Vivado/2016.1
ENV LD_LIBRARY_PATH=/tools/Xilinx/Vivado/2016.1/lib/lnx64.o
