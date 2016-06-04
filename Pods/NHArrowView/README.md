# NHArrowView

## Description

A simple directional arrow with animated rotation

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

The arrow view can be included in IB or created programmatically. It is a simple UIView subclass that offers a some styling and convenience methods for rotating the arrow to a specified angle in degree or radian.

```
  #import "NHArrowView.h"
  @property(nonatomic,strong) IBOutlet NHArrowView *arrow;

  self.arrow.headLength = 20.;
  self.arrow.headWidth = 20.;
  self.arrow.tailWidth = 7.;
  [self.arrow animatedRotateToDegree: 135.];
```

## Installation

To install NHArrowView in another project, simply add the following line to your Podfile:

    pod "NHArrowView", :git "git@github.ehealthinnovation.org:JDRF/NHArrowView.git"

## Documentation

`appledoc` of the pod can be found at `./doc/html/index.html`

## Author

Nathaniel Hamming, nhamming@ehealthinnovation.org

## License

NHArrowView is available under the MIT license. See the LICENSE file for more info.

