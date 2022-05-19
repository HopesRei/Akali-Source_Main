function start(song) -- do nothing

end

function setDefault(id)
	_G['defaultStrum'..id..'X'] = getActorX(id)
	_G['defaultStrum'..id..'Y'] = getActorY(id)
	_G['defaultStrum'..id..'Z'] = getActorAngle(id)	
	setActorAngle(0,id)
end

function update(elapsed)
    if difficulty == 2 and curStep > 400 then
        local currentBeat = (songPos / 1000)*(bpm/60)
		for i=0,17 do
			setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end

    elseif difficulty == 0 and curStep > 400 then
        local currentBeat = (songPos / 1000)*(bpm/60)
		for i=0,17 do
			setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end

    end

end

function beatHit(beat) -- do nothing

end

function stepHit(step) -- do nothing
	if curStep == 12 then
		changeMania(11);
	elseif  curStep == 15 then
		changeMania(10);
	elseif  curStep == 35 then
		changeMania(11);
	elseif  curStep == 38 then
		changeMania(10);
	elseif  curStep == 48 then
		changeMania(11);
	elseif  curStep == 52 then
		changeMania(10);
	elseif  curStep == 56 then
		changeMania(11);
	elseif  curStep == 60 then
		changeMania(10);
	elseif  curStep == 85 then
		changeMania(11);
	elseif  curStep == 90 then
		changeMania(10);
    end

end

function playerTwoTurn()
    tweenCameraZoom(1.3,(crochet * 4) / 1000)
end

function playerOneTurn()
    tweenCameraZoom(1,(crochet * 4) / 1000)
end