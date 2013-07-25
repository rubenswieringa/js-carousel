js-carousel
===========

All this thing does is set your images their `left`-property from 100% or -100% to 0. Transitions and layout should be defined by your own CSS.

The library expects any container-element containing one or more absolutely positioned `<img/>` elements, other child-elements will be ignored. Pass a jQuery-representation of the container to the Carousel constructor and you're done.

This library has jQuery and Modernizr as dependencies.

## Example:

### HTML:

```
<figure>
  <img src="image1.jpg" />
  <img src="image2.jpg" />
  <img src="image3.jpg" />
</figure>
```

### CSS:

```
figure.carousel {
  width: 600px;
  height: 400px;
  position: relative;
  overflow: hidden;
}

figure.carousel img {
  display: block;
  position: absolute;
  top: 0;
  left: 0;
  transition: left 1s;
}
```

### JS:

```
new Carousel( $('figure.carousel'));
```

If your navigation-elements are contained by your container, provided they have ```next``` and ```prev``` as their CSS class-names, Carousel will automatically detect them. Alternatively you can pass next/previous navigation-elements to the constructor:

```
new Carousel( $('figure.carousel'), { next: $('#my_next_btn'), prev: $('#my_prev_btn') });
```

Carousel can also slide automatically:

```
new Carousel( $('figure.carousel'), { auto: true });

// or pass milliseconds:
new Carousel( $('figure.carousel'), { auto: 3300 });
```

## Options

* **next** - *Next* navigation-button element
* **prev** - *Previous* navigation-button element
* **auto** - Set to true to enable automatic sliding. Alternatively you may provide the amount of milliseconds between each automatic slide.
* **slideSelector** - Tag-name or DOM-selector for your slides. Defaults to ```>img```.
