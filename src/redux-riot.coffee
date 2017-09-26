# Redux-Riot mixin

{bindActionCreators} = require('redux')

NONE = {}
DEFAULT_SELECTOR = (state) -> state

module.exports = (store) ->

    # Bind tag's actions to Redux Store
    actions: (actions...) ->
        @actions = {}
        for actions_ in actions
            continue unless actions_?
            actions_ = bindActionCreators(actions_, store.dispatch)
            @actions[k] = actions_[k] for k of actions_
        return @actions

    # Dispatch action from tag
    dispatch: store.dispatch

    # Get global state
    getState: store.getState

    # Subscribe on store updates
    subscribe: (selector, callback, changes) ->
        tag = @
        previous = NONE

        selector ?= DEFAULT_SELECTOR
        callback ?= (state) ->
            tag.state = state
            tag.update()
        changes  ?= selector.recomputations or DEFAULT_SELECTOR

        compute = ->
            state = store.getState()
            selected = selector(state)

            version = changes(selected)
            changed = version != previous
            previous = version

            callback(selected) if changed

        compute()

        unsubscribe = store.subscribe(compute)
        @on 'unmount', unsubscribe

        return unsubscribe
