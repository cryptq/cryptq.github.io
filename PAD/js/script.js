// .~•* BLESS THIS MESS *•~. //

// go to line 284 and try out other sounds

// adjust note envelope, time in seconds
var attackTime = 1.0;
var releaseTime = 1.0;

var keyCodeNotes = {
  81: 'C5', // q
  87: 'D5', // w
  69: 'E5', // e
  82: 'F5', // r
  84: 'G5', // t
  89: 'A5', // y
  85: 'B5', // u
  73: 'C6', // i
  79: 'D6', // o
  80: 'E6', // p
  219: 'F6', // [
  221: 'G6', // ]

  65: 'C4', // a
  83: 'D4', // s
  68: 'E4', // d
  70: 'F4', // f
  71: 'G4', // g
  72: 'A4', // h
  74: 'B4', // j
  75: 'C5', // k
  76: 'D5', // l
  186: 'E5', // ;
  222: 'F5', // '

  90: 'C3', // z
  88: 'D3', // x
  67: 'E3', // c
  86: 'F3', // v
  66: 'G3', // b
  78: 'A3', // n
  77: 'B3', // m
  188: 'C4', // ,
  190: 'D4', // .
  191: 'E4', // /

};


/* globals keyCodeNotes */


function Tone( voice, keyCode ) {
  this.voice = voice;
  this.audio = voice.audio;
  var osc = this.audio.createOscillator();
  var noteName = this.noteName = keyCodeNotes[ keyCode ];
  osc.frequency.value = getFrequency( noteName, voice.octaveOffset );
  osc.type = voice.type;
  osc.detune.value = voice.detune;

  var gain = this.audio.createGain();
  gain.gain.value = 0;

  osc.connect( gain );
  osc.start();
  gain.connect( voice.output );

  this.osc = osc;
  this.gain = gain;
  
  this.isKeyDown = false;
}

var semitoneMap = {
  C: -9,
  D: -7,
  E: -5,
  F: -4,
  G: -2,
  A: 0,
  B: 2,
};

var PIANO_BASE = Math.pow( 2, 1/12 );

/**
 * @param {String} noteName - note and octave: 'C4'
 */
function getFrequency( noteName, octaveOffset ) {
  var note = noteName[0];
  var octave = noteName[1];
  var semitone = semitoneMap[ note ] + ( octave - 4 + octaveOffset ) * 12;
  return 440 * Math.pow( PIANO_BASE, semitone );
}

var proto = Tone.prototype;


proto.rampGain = function( value, duration ) {
  var now = this.audio.currentTime;
  var currentValue = this.getCurrentGainValue( now );

  this.gain.gain.cancelScheduledValues( now );
  this.gain.gain.setValueAtTime( currentValue, now );
  this.gain.gain.linearRampToValueAtTime( value, now + duration );

  this.gainRamp = {
    then: now,
    duration: duration,
    from: currentValue,
    to: value
  };

};

proto.getCurrentGainValue = function( now ) {
  var gainRamp = this.gainRamp;
  if ( !gainRamp ) {
    return 0;
  }
  // calc duration since last, decimal 0..1
  var rampDuration = Math.min( 1, ( now - gainRamp.then ) / gainRamp.duration );
  return lerp( gainRamp.from, gainRamp.to, rampDuration );
};

function lerp( a, b, t ) {
  return ( b - a ) * t + a;
}

// -----  ----- //

proto.keyDown = function() {
  if ( this.isKeyDown ) {
    return;
  }
  this.rampGain( this.voice.volume, attackTime );
  // this.gain.gain.value = this.voice.volume;
  this.isKeyDown = true;
};

proto.keyUp = function() {
  // this.gain.gain.value = 0;
  this.rampGain( 0, releaseTime );
  this.isKeyDown = false;
};


/* globals keyCodeNotes, Tone */

function Voice( audio, output, options ) {
  // apply options
  for ( var prop in options ) {
    this[ prop ] = options[ prop ];
  }
  this.audio = audio;
  this.output = output;
  this.createTones();
}

var proto = Voice.prototype;

proto.octaveOffset = 0;
proto.type = 'triangle';
proto.volume = 1;
proto.detune = 0;

proto.createTones = function() {
  // tones are per keyboard key
  this.tones = {};
  this.onTones = {};

  for ( var keyCode in keyCodeNotes ) {
    var tone = new Tone( this, keyCode );
    this.tones[ keyCode ] = tone;
  }

};

proto.keyDown = function( keyCode ) {
  this.doTone( keyCode, 'keyDown' );
};

proto.keyUp = function( keyCode ) {
  this.doTone( keyCode, 'keyUp' );
};

proto.doTone = function( keyCode, method ) {
  var tone = this.tones[ keyCode ];
  if ( tone ) {
    tone[ method ]();
  }
};


/* globals keyCodeNotes, Voice */

var AudioCtx = window.AudioContext || window.webkitAudioContext;

// -----  ----- //

function Instrument() {
  this.voices = [];
  document.addEventListener( 'keydown', this );
  document.addEventListener( 'keyup', this );
  this.audio = new AudioCtx();
  // output
  this.output = this.audio.createGain();
  this.output.gain.value = 1;
  this.output.connect( this.audio.destination );
}

var proto = Instrument.prototype;

// ----- events ----- //

proto.handleEvent = function( event ) {
  var handler = this[ 'on' + event.type ];
  if ( this[ 'on' + event.type ] ) {
    handler.call( this, event );
  }
};

proto.onkeydown = function( event ) {
  if ( event.keyCode == 91 ) {
    this.isCmdDown = true;
  }
  if ( this.isCmdDown ) {
    return;
  }

  this.keyDown( event.keyCode );
};

proto.onkeyup = function( event ) {
  if ( event.keyCode == 91 ) {
    this.isCmdDown = false;
  }
  this.keyUp( event.keyCode );
};

// ----- play/stop note ----- //

proto.keyDown = function( keyCode ) {
  var noteName = keyCodeNotes[ keyCode ];
  if ( !noteName ) {
    return;
  }
  changeKeyElemDown( keyCode, 'add' );
  this.voices.forEach( function( voice ) {
    voice.keyDown( keyCode );
  });

};

proto.keyUp = function( keyCode ) {
  var noteName = keyCodeNotes[ keyCode ];
  if ( !noteName ) {
    return;
  }
  changeKeyElemDown( keyCode, 'remove' );
  this.voices.forEach( function( voice ) {
    voice.keyUp( keyCode );
  });
};

var keyboardElem = document.querySelector('.keyboard');

function changeKeyElemDown( keyCode, method ) {
  var keyElem = keyboardElem.querySelector( '.keyboard__key--' + keyCode );
  keyElem.classList[ method ]('is-down');
}

// ----- addVoice ----- //

// shape, volume, detune, octave offset
proto.addVoice = function( options ) {
  options = options || {};
  var voice = new Voice( this.audio, this.output, options );
  this.voices.push( voice );
};

//-----------------------

var synth = new Instrument();

/**/
// buzzy
synth.addVoice({
  type: 'square',
  volume: 0.1
});

synth.addVoice({
  type: 'square',
  volume: 0.1,
  octaveOffset: -1,
  detune: -5
});
/**/

/** /
// holy
synth.addVoice({
  type: 'sine',
  volume: 0.2
});

synth.addVoice({
  type: 'sine',
  volume: 0.2,
  detune: -5
});

synth.addVoice({
  type: 'sine',
  volume: 0.2,
  detune: -10
});

synth.addVoice({
  type: 'sine',
  volume: 0.2,
  detune: 7
});

synth.addVoice({
  type: 'sine',
  volume: 0.2,
  detune: 5
});
/**/

/** /
// organ
synth.addVoice({
  volume: 0.5
});

synth.addVoice({
  octaveOffset: -1,
  volume: 0.3
});

synth.addVoice({
  octaveOffset: 1,
  volume: 0.3
});
/**/


//-----------------------

var canvas = document.querySelector('canvas');
var canvasWidth = canvas.width = window.innerWidth - 40;
var canvasHeight = canvas.height = 300;
var ctx = canvas.getContext('2d');

var analyzer = synth.audio.createAnalyser();
synth.output.connect(  analyzer );

analyzer.minDecibels = -90;
analyzer.maxDecibels = -10;
analyzer.smoothingTimeConstant = 0.85;

analyzer.fftSize = 512;
var bufferLength = analyzer.frequencyBinCount;
var dataArray = new Uint8Array( bufferLength );


ctx.fillStyle = 'white';
ctx.fillRect( 0, 0, canvasWidth, canvasHeight );

function render() {
  analyzer.getByteFrequencyData( dataArray );

  // shift down
  var canvasImageData = ctx.getImageData( 0, 0, canvasWidth, canvasHeight );
  ctx.putImageData( canvasImageData, 0, 6 );

  ctx.fillStyle = 'black';
  ctx.fillRect( 0, 0, canvasWidth, canvasHeight );

  var barWidth = Math.ceil( canvasWidth / bufferLength);

  for ( var i = 0; i < bufferLength; i++ ) {
    var x = Math.floor( i * barWidth );
    var amp = dataArray[i] / 200; // should be 256
    var hue = Math.round( amp * 210 + 210 );
    var sat = 50 + ( 1- amp) * 50;
    var alpha = amp
    ctx.fillStyle = 'hsla(' + hue + ', 100%, ' + 50 + '%, ' + 1 + ')';
    var barHeight = amp * canvasHeight;
    var y = canvasHeight - barHeight;
    ctx.fillRect( x, y, barWidth, barHeight );
  }
  
  requestAnimationFrame( render );
}

render();