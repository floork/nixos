{ pkgs, ... }:
{
    text = ''
      # See this wiki page for more info:
      # https://github.com/dylanaraps/neofetch/wiki/Customizing-Info
      print_info() {
          info title
          info underline

          info "OS" distro
          info "Host" model
          info "Kernel" kernel
          info "Uptime" uptime
          info "Packages" packages
          info "Shell" shell
          info "Terminal" term
          info "CPU" cpu
          info "GPU" gpu
          info "Memory" memory

          info "Disk" disk
          info "Local IP" local_ip
      }

      title_fqdn="off"
      kernel_shorthand="on"

      distro_shorthand="off"

      os_arch="on"

      uptime_shorthand="on"

      memory_percent="off"

      memory_unit="mib"

      package_managers="on"

      shell_path="off"

      shell_version="on"

      speed_type="bios_limit"

      speed_shorthand="off"

      cpu_brand="on"

      cpu_speed="on"

      cpu_cores="logical"

      cpu_temp="off"

      gpu_brand="on"

      gpu_type="all"

      refresh_rate="off"

      gtk_shorthand="off"

      gtk2="on"

      gtk3="on"

      public_ip_host="http://ident.me"

      public_ip_timeout=2

      de_version="on"

      disk_show=('/home')

      disk_subtitle="mount"

      disk_percent="on"

      music_player="auto"

      song_format="%artist% - %album% - %title%"

      song_shorthand="off"

      mpc_args=()

      colors=(distro)

      bold="on"

      underline_enabled="on"

      underline_char="-"

      separator=":"

      block_range=(0 15)

      color_blocks="on"

      block_width=3

      block_height=1

      col_offset="auto"

      bar_char_elapsed="-"
      bar_char_total="="

      bar_border="on"

      bar_length=15

      bar_color_elapsed="distro"
      bar_color_total="distro"

      cpu_display="off"
      memory_display="off"
      battery_display="off"
      disk_display="off"

      image_backend="ascii"

      image_source="auto"

      ascii_distro="tux"

      ascii_bold="on"

      image_loop="off"

      crop_mode="normal"

      crop_offset="center"

      image_size="auto"

      gap=3

      yoffset=0
      xoffset=0

      background_color=

      stdout="off"
    '';
}
