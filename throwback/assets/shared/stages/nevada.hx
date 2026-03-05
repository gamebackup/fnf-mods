import openfl.display.BlendMode;

playCutscenes = true;
var manualCamera:Bool = false;

function postCreate() {
    glow.blend = BlendMode.ADD;

    comboGroup.x += 1100;
    comboGroup.y += 450;

    strumLines.members[3].characters[0].x += 300;
    strumLines.members[3].characters[0].y += 200;
}

function beatHit(curBeat:Int) {
    if (curBeat % 2 == 0) {
        if (strumLines.members[3].characters[0].animation.curAnim.name == 'idle' && strumLines.members[3].characters[0].animation.curAnim.curFrame >= 8)
            strumLines.members[3].characters[0].playAnim('idle', true);
    }
}

function onCameraMove(e) {
    if (manualCamera) e.cancel();
}