# anibg
A script that will automatically resize a window of MPV to a resolution that
will make the video cover the entire screen, and then move this window to the
same rendering layer as the desktop background image, in order to make it a
living background. The scaling of the video file will be done so the aspect
ratio is maintained, and the result will be centered in relation to the screen.


## Acknowledgements and Thanks

This project was created after I got inspired by a [Reddit post][14] made by
[`waicool20`][15], who successfully managed to put a MPV window as a living
background image. However, I found it rudimentary, and it used the old
`devilspie`, so I took it upon myself to modernize it and make so that is
automatically scaled the video to appropriate sizes.


## Requirements

- [bc][1] (A calculator capable of floats)
- [coreutils][7] (Expected core utilities)
- [devilspie2][2] (Execute actions on windows)
- [ffmpeg][3] (Media file information)
- [MPV][4] (Media player)
- [sed][6] (A stream editor)
- [xdpyinfo][5] (Screen information [for X])

Most of these packages are probably already installed on your system, but here
is a one-liner to install them all on Debian 10.0 Buster:

```bash
sudo apt install bc coreutils devilspie2 ffmpeg mpv sed x11-utils
```


## Installation

Begin by moving into a suitable directory and cloning this repository from
GitHub.

```bash
git clone git@github.com:JonasAlfredsson/anibg.git
```

You should be able to see two folders, and inside the `src` directory there will
be two files that needs to be kept together for this script to work as intended.
The `anibg` file is the main executable for this project, and it will source the
`utils` file during runtime, so do not separate them.

Inside the `examples` folder you will find a fully functional `.lua`
configuration script (designed for MPV) which should be moved to the config
folder of `devilspie2` (usually `~/.config/devilspie2`).

After this, it should be possible to use this program by always providing the
full path to the `anibg` file, but to be able to call the executable from
anywhere on your system you can also add this script's `scr` folder to your
PATH. This can be done by including the following line at the bottom of your
`~/.bashrc` or `~/.zshrc` file.

```
PATH="/path/to/anibg/src:${PATH}"
```

By sourcing the edited file again, or just opening a new terminal, it should now
be possible to use `anibg` without providing the full path.


## Usage

To use this program you call on the `anibg` executable and provide a video file
as the first and only argument. The script will then try to adjust the size of
the MPV player's window to make sure the video stream covers the entirety of
your screen before moving it to the background image layer. Here are some
example commands:

```bash
/full/path/to/anibg /full/path/to/video.mp4
```

```bash
relative/path/to/anibg ../realative/path/to/video.mp4
```

And if you have the `anibg` executable in your PATH you can do this as well:

```bash
anibg realative/path/to/video.mp4
```


## Configuration Options

At the top of the main `anibg` script file there exist four settings that can
be changed by the user, accompanied with what values are valid.

### The `devilspie2` Config File (dp2_conf)
This should be the path to the `.lua` configuration file that is used by
`devilspie2` when resizing the video window of the MPV player. If your
installation placed it somewhere else than `~/.config/devilspie2/` you can
change it here.

### Automatic Resolution (automaticResolution)
If you have a special video file, that is not recognized correctly by the
automatic resizing function, you can turn this functionality off and manually
edit the `MPV Wallpape.lua` file. Succeeding runs of `anibg` will then not
modify this config file, in order to not mess with your custom settings.

### Hardware Decoder (hwDecoder)
It is possible for MPV to use hardware accelerated decoding on systems where
this option is available. There are a couple of different combinations to this,
but I have categorized them into four groups for simplicity:

- `none` - Only use software decoding.
    - This will be compatible with all systems that have a CPU, but will use
      a lot of system resources
- `auto` - Let MPV find best decoder.
    - MPV is usually quite good at finding what options are available, and will
      most likely be able to automatically configure the decoder correctly by
      itself.
- `intel` - Use the Intel specific hardware decoder.
    - If the screen you are using is getting its signal from the integrated
      Intel graphics you can use this option, as it will use the hardware
      decoders available in the graphics part of the CPU instead.
- `nvidia` - Use the Nvidia specific hardware decoder.
    - If you have a Nvidia graphics card you can use this setting, as it will
      offload all the decoding to your dedicated graphics card instead.

If you are unsure what to use I would leave it at `auto`, but you can test the
different settings wile monitoring your system to find the one with best
performance. For more information about this you can check out all the
[Hardware decoder options][9] on the MPV site.

### Scaler Algorithm (scaler)
When scaling an image, or a video feed, some kind of algorithm is needed in
order to calculate what color all the pixels in the resized variant should be.
This is a complicated problem that has a quality/speed tradeoff which you might
need to take into consideration.

A system using software decoding might not have the necessary computing power to
use the scaler that will produce the best results, and using this will result
in a low framerate. The slowest decoder will most likely require a dedicated
graphics card for acceptable performance on higher resolution video feeds.

There are three options available, with slower equating to better quality.

- `fast` - bilinear
    - Bilinear hardware texture filtering. This is the fastest scaler, but the
      quality is not that good. This is also MPV's default scaler for
      compatibility reasons.
- `medium` - spline36
    - This one has quite good quality at moderate resource requirements.
- `slow` - ewa_lanczossharp
    - This is a slightly sharpened version of another scaler called
      `ewa_lanczos`, and it is also using some additional pre-tuned parameters.
      If your hardware can run it, this is probably what you should use by
      default.

Like with the hardware decoder options, play around with the settings to see
which one works best on your system. More information can be found in the
[Scaler options][8] section on the MPV site.


## Resources

The subreddit [LivingBackgrounds][16] is quite nice if you are looking for
content to use as a living background, and so it the YouTube channel
[AA VFX][17].

Furthermore, there are actually quite a few commands available for `devilspie2`
that can be used to manipulate windows on the system. The example here with MPV
player as a background image is just one option, and much more advanced actions
can be made if you want. More information can be found in the [manual][13].



[1]: https://www.gnu.org/software/bc/manual/html_mono/bc.html
[2]: https://www.nongnu.org/devilspie2/
[3]: https://ffmpeg.org/
[4]: https://mpv.io/
[5]: https://linux.die.net/man/1/xdpyinfo
[6]: https://www.gnu.org/software/sed/manual/sed.html
[7]: https://www.gnu.org/software/coreutils/
[8]: https://mpv.io/manual/master/#options-scale
[9]: https://mpv.io/manual/master/#options-hwdec
[10]: https://stackoverflow.com/questions/33389017/replace-only-the-first-matching-line-while-preserving-leading-whitespace
[11]: https://stackoverflow.com/questions/59895/get-the-source-directory-of-a-bash-script-from-within-the-script-itself
[12]: https://medium.com/@Aenon/bash-location-of-current-script-76db7fd2e388
[13]: https://git.savannah.gnu.org/cgit/devilspie2.git/plain/README
[14]: https://old.reddit.com/r/LivingBackgrounds/comments/61ff6n/living_backgrounds_on_linux/
[15]: https://old.reddit.com/user/waicool20
[16]: https://old.reddit.com/r/LivingBackgrounds/
[17]: https://www.youtube.com/user/dvdangor2011/videos
