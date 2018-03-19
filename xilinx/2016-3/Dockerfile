FROM base

# Install required packages
# Vivado requires GCC
# Need xorg to launch gui apps
# wget required for src upload
RUN apt-get -y update && apt-get install -y \
    build-essential \
    wget \
    xorg \
    && rm -rf /var/lib/apt/lists/

# Setup environment variables
ENV PATH=/tools/Xilinx/DocNav:/tools/Xilinx/Vivado/2016.3/bin:/tools/Xilinx/Vivado_HLS/2016.3/bin:$PATH
ENV XILINX_VIVADO=/tools/Xilinx/Vivado/2016.3
ENV LD_LIBRARY_PATH=/tools/Xilinx/Vivado/2016.3/lib/lnx64.o

# Upload the Vivado install config file
COPY install_config.txt /install/

# Run the installer
RUN cd /install \
    && wget 192.168.1.16:8000/Xilinx_Vivado_SDK_2016.3_1011_1.tar.gz \
    && tar zxvf Xilinx_Vivado_SDK_2016.3_1011_1.tar.gz \
    && cd Xilinx_Vivado_SDK_2016.3_1011_1 \
    && ./xsetup --agree XilinxEULA,3rdPartyEULA,WebTalkTerms --batch Install --config /install/install_config.txt \
    && cd / \
    && rm -rf /install
