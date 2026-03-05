// slowly turns to night and at ballistic bit apply rtx color shader thingy from basegame
// also add rain shader
// move cam up to sky (maybe zoom in) and back down again during transition to evil bomb mode
// add a fire ash overlay during the ballistic bit
// a defuse mechanic where you press a combination of keys to defuse the bomb (like the one from chinos animation)
// change the healthbar similar to chinos animation (https://www.youtube.com/watch?v=j1D2PQAWFIE)

import flixel.math.FlxAngle;

var rainShader:CustomShader;
var blurShader:CustomShader;
var bfLightingShader:CustomShader;
var dadLightingShader:CustomShader;
var gfLightingShader:CustomShader;

var manualCam:Bool = false;

function postCreate() {
    FlxG.camera.followLerp = 0.1;
    camOffsetAmount = 35;

    for (i in 0...3) {
        strumLines.members[i].characters[0].flipY = true;
        strumLines.members[i].characters[0].alpha = 0.3;
        strumLines.members[i].characters[0].scale.y *= 0.5;
        strumLines.members[i].characters[0].x += 20;
    }
    strumLines.members[0].characters[0].y += 530;
    strumLines.members[1].characters[0].y += 200;
    strumLines.members[2].characters[0].y += 400;

    comboGroup.x += 400;
    comboGroup.y += 100;

    if (Options.gameplayShaders) {
        rainShader = new CustomShader("rain");
        
        blurShader = new CustomShader(Options.intensiveBlur ? "engine/editorBlur" : "engine/editorBlurFast");
        chain.shader = angyChain.shader = blurShader;

        dadLightingShader = new CustomShader("dropShadow");
        bfLightingShader = new CustomShader("dropShadow");
        gfLightingShader = new CustomShader("dropShadow");

        dadLightingShader.satinColor = bfLightingShader.satinColor = gfLightingShader.satinColor = [2, 1.5, 1, 0.25];
        dadLightingShader.innerShadowColor = bfLightingShader.innerShadowColor = gfLightingShader.innerShadowColor = [0.6, 0.6, 0.1, 0.8];
        dadLightingShader.innerShadowAngle = FlxAngle.asRadians(-135);
        bfLightingShader.innerShadowAngle = FlxAngle.asRadians(-135);
        gfLightingShader.innerShadowAngle = FlxAngle.asRadians(-135);

        dadLightingShader.innerShadowDistance = -30;
        bfLightingShader.innerShadowDistance = 30;
        gfLightingShader.innerShadowDistance = -15;

        strumLines.members[0].characters[1].shader = dadLightingShader;
        strumLines.members[1].characters[1].shader = bfLightingShader;
        strumLines.members[2].characters[1].shader = gfLightingShader;
    }

    for (lights in [lightLeft, lightRight]) {
        lights.blend = 1;
    }
}

function onEvent(e) {
    if (e.event.name != 'Camera Movement') return;
    new FlxTimer().start(0.01, (_) -> {
        if (curCameraTarget == 1) defaultCamZoom = 0.65;
        else defaultCamZoom = 0.55;
    });
}

function onSongStart() {
    camZoomingStrength = 0;
    camZooming = true;
}

function beatHit(curBeat:Int) {
    switch (curBeat) {
        case 31:
            camZoomingStrength = 1;
        case 360:
            camHUD.flash(0xFFFFFFFF, 1);
            camHUD.fade(0xFF000000, 3);
            FlxG.camera.fade(0xFF000000, 0);

            for (stageItems in [bg, sideStuff, chain]) {
                stageItems.alpha = 0;
            }

            for (angyItems in [angySky, angyBg, angySideStuff, wip]) {
                angyItems.alpha = 1;
            }
            angyChain.alpha = 0.8;

            for (lights in [lightLeft, lightRight]) {
                lights.alpha = 0.3;
            }

            for (dadItems in [strumLines.members[0].characters[0], strumLines.members[0].characters[1]]) {
                dadItems.alpha = 0.001;
            }
        case 392:
            FlxG.camera.addShader(rainShader);
            camHUD.fade(0xFF000000, 2, true);
            FlxG.camera.fade(0xFF000000, 4, true);
    }
}

function update(elapsed:Float) {
    if (Options.gameplayShaders) {
        rainShader.iTime = Conductor.songPosition / 1000;
        rainShader.iIntensity = 0.1;
        rainShader.iTimescale = 0.5;
    }
}

function onCameraMove(e) {
    if (manualCam) e.cancel();
}

function middleCam(enabled:Bool = false) {
    manualCam = enabled;
    if (!enabled) return;

    // i'll do this later :)
    // camFollow.x = ;
    // camFollow.y = ;
}

function onGameOver()
{
    if (Options.gameplayShaders) {
        FlxG.camera.removeShader(rainShader);
        chain.shader = null;
    }
}

function destroy()
{
    if (Options.gameplayShaders) {
        FlxG.camera.removeShader(rainShader);
        chain.shader = null;
    }
}