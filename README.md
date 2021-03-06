# rt-haskell

A Path Tracer in Haskell

We follow mostly the P. Shirley's architecture with couple of differences.

The branches follow the chapters from [online](raytracing.github.io/)
repository.


## Show case

- Small color gradient in 01-ppm branch:

![ppm-color-gradient](./images/gradient.png)


- Red sphere from 04-sphere branch:

![red-sphere](./images/sphere.png)

- Normals from branch 05-surface:

![surface-normals](./images/05-surface.png)

- Multiple objects from branch 06-multiple:

![multiple-normals](./images/multiple.png)

- Antialiasing from branch 07-antialias:

![antialias-normals](./images/antialias.png)

- Diffuse image from branch 08-diffuse

![diffuse-image](./images/diffuse.png)

- Metal image from branch 09-metal

![metal-image-01](./images/metal.png)

- Fuzzy metal image from branch 09-metal

![metal-image-02](./images/fuzzmetal.png)

- Dielectric from branch 10-dielectric

![dielectric-01](./images/diel01.png)

- Camera focus from branch 11-camera

![focus-image-02](./images/focus.png)

- A version of final scene from branch 12-oneweekend

![oneweekend-final-image-01](./images/final-oneweekend-diffuse.png)

- Another version of final scene branch 12-oneweekend

![oneweekend-final-image-02](./images/final-oneweekend-metallic.png)

- Fixed version of final scene. The fix happens around branch 14-texture

![oneweekend-final-image-03](./images/oneweekendfinal.png)

- Final one weekend final branch 14-texture

![oneweekend-final-image-04](./images/oneweekend.png)

- Motion blur branch 14-texture

![motion-blur-image-01](./images/motionblur.png)

- Checkered texture from branch 14-texture

![checker-image-01](./images/checker.png)

- Perlin Noise with Light from branch 14-texture

![perlin-image-01](./images/light.png)

- Earth image from branch 14-texture

![earth-image-01](./images/earth.png)

- Cornell box image from branch 15-instances

![cornell-box-01](./images/cornell.png)

- Cornell smoke boxes from branch 16-constant-density-mediums

![cornell-box-02](./images/smoke.png)

- Cornell sphere and a box from branch 17-scattering-pdf

![cornell-box-03](./images/cornellFinal.png)

- Cornell box from 18-spectral

![cornell-box-04](./images/spectral.png)



## Some Notes

### RNGs and performance

The from branch 08-diffuse an onwards as the usage of random functions become
prominent the performance decreases considerably. However the inverse is also
true, if you can place your random generators efficiently, you can easily
increase your performance. I simply concentrated on getting the images right.
Do not be surprised if you find that some other arrangement of RNGs result in
better performance.


### Spectral Rendering

Spectral rendering is done through use of spectral textures. The general idea
is that material determines the behaviour of the surface distribution function
and the texture determines its color space.
You can see how spectral textures are used in `SpectralScene.hs`. The
rendering function determines that the scene is spectral using the data type
of the background. If the background is of type `PixSpecSampled` then it
switches to spectral rendering.

Another point is the setting spectral data from rgb color model. This done
through the convenience function `fromRGBModel`. You can try specifying
spectrum data directly as well. A `SampledSpectrum` is simply a non empty list
of wavelength, power tuple along with a spectrum type specifier. This last
call is not entirely necessary, since for all the operations between spectrums
we don't care about the type of the spectrum, but it becomes convenient to
know when you are doing conversions between spectrum to trichromatic systems.

Lastly the beware that spectral rendering takes much more time than its rgb
equivalent. The spectral cornell box whose image can be found in the
18-spectral branch took `3931.857353s` with 5 samples per pixel and 5 ray
bounce limit for an image width 320 and aspect ratio 16:9. The sampled
wavelength range is `[380, 720]`, and the sampling step size is 5, so we sampled
power values for a list of wavelengths such as `[380, 385, ..., 720]`.

### Rotations

We use a slightly more flexible approach to rotations than the original books.
Basically the rotation is done using rotation matrices which are constructed
from the angle and axis information provided during the setup of Rotatable
type. Though it can be generalized into arbitrary axis, we are currently
supporting only XYZ axes which are passed as RotationAxis type. Also our
rotations are inversed with respect to the book. That which is in clockwise is
counter clockwise in our case.

## Planned Features

I hope to make the tracer as minimal but useful as possible.
Here is a list of planned features:

- Loading assets with obj files
- Spectral rendering switch: done
- BVH acceleration structure: done but not tested.
- Multithreaded rendering: This is as easy as passing -N3 as option now, since
  most of the code is composed of pure functions.
