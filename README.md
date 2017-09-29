# redux-riot

[![npm version](https://badge.fury.io/js/redux-riot.svg)](https://badge.fury.io/js/redux-riot)

A Riot integration to Redux

## Installation

```bash
npm install --save redux-riot
```

### Dependencies

`redux-riot` depends on `redux`, `riot`.

## How to use?

### Configure and setup the mixin

```js

import Riot from 'riot'
import RiotReduxMixin from 'redux-riot';
import {createStore} from 'redux';

const store = createStore(
    // ...
)

Riot.mixin(RiotReduxMixin(store)) // install globally
Riot.mixin('redux', RiotReduxMixin(store)) // or shared
```

### Use in your tags

```js

    this.mixin('redux') // skip if the mixin is installed globally
```

## License

This project is licensed under the MIT license, Copyright (c) 2017 Kirill Klenov. For more information see `LICENSE.md`.

## Acknowledgements

[Dan Abramov](https://github.com/gaearon) for Redux and Riot team for [Riot](https://github.com/riot/riot). A Simple and elegant component-based UI library
