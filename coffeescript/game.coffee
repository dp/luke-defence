Game =
    init: ->
        @renderer = PIXI.autoDetectRenderer(1024, 768)
        # document.body.appendChild(@renderer.view)
        document.getElementById('gamebox').appendChild(@renderer.view)
        @stage = new PIXI.Container()
        @renderer.render(@stage)
        @renderer.view.style.position = "absolute"
        @renderer.view.style.display = "block"
        @renderer.autoResize = true

        PIXI.loader
            .add("images/tileset.json")
            .add("images/bg.png")
            .load( => @setup())

    setup: ->
        console.log 'Loaded'
        @loadBg()
        @showLevel()
        ticker = PIXI.ticker.shared
        ticker.speed = 1
        ticker.add (dTime) =>
            @update()

    loadBg: ->
        texture = PIXI.utils.TextureCache["images/bg.png"]
        sprite = new PIXI.Sprite(texture)
        sprite.x = 0
        sprite.y = 0
        @stage.addChild(sprite)

    showLevel: ->
        level = Levels.level1
        console.log level
        for point in level.path
            @showSprite 'mushroom_1', point[0], point[1]
        for point in level.build_areas
            @showSprite 'mushroom_2', point[0], point[1]


    showSprite: (image_name, x,y) ->
        texture = PIXI.utils.TextureCache["#{image_name}.png"]
        sprite = new PIXI.Sprite(texture)
        sprite.x = x
        sprite.y = y
        @stage.addChild(sprite)

    update: (dtime) ->
        @render()

    render: ->
        @renderer.render(@stage)

    stop: ->
        PIXI.ticker.shared.stop()

    start: ->
        PIXI.ticker.shared.start()



window.Game = Game