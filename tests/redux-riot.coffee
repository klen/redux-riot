RR = require('../src/redux-riot.coffee')
{spy} = require('sinon')
configureStore = require('redux-mock-store').default

tagFactory = -> on: spy(), update: spy()
storeFactory = configureStore([])

exports.ReduxRiot =

    setUp: (callback) ->
        @store = storeFactory({value: 1})
        callback()

    'Initialize mixin': (test) ->
        mixin = RR(@store)

        test.ok(mixin.actions)
        test.ok(mixin.dispatch)
        test.ok(mixin.getState)
        test.ok(mixin.subscribe)

        test.done()

    'Mixin.dispatch is working': (test) ->
        mixin = RR(@store)

        mixin.dispatch(type: 'TEST')
        action = @store.getActions()[0]
        test.equal(action.type, 'TEST')

        test.done()

    'Mixin.getState is working': (test) ->
        mixin = RR(@store)
        tag = tagFactory()
        tag = {tag..., mixin...}

        state = tag.getState()
        test.equal(state.value, 1)

        test.done()

    'Mixin.subscribe is working': (test) ->
        mixin = RR(@store)
        tag = tagFactory()
        tag = {tag..., mixin...}

        tag.subscribe (state) -> state.value
        test.ok(tag.on.called)

        tag.dispatch(type: 'TEST')
        test.equal(tag.state, 1)
        test.ok(tag.update.called)

        test.done()
