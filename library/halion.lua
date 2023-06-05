---@meta

---@class AudioFile The AudioFile.open function creates an AudioFile object of the specified audio file. The AudioFile object can be used to retrieve information from the audio file.
---@field valid boolean Indicates if the file is a supported audio file and whether it could be opened or not.
---@field fileName string The file name that was used for opening the audio file.
---@field rate number The sample rate of the audio file. Returns nil if the audio file could not be opened or is invalid.
---@field bits number The bit depth of the audio file. Returns nil if the audio file could not be opened or is invalid.
---@field channels number The number of channels of the audio file. Returns nil if the audio file could not be opened or is invalid.
---@field length number The number of samples in the audio file. Returns nil if the audio file could not be opened or is invalid.
---@field rootKey number The root key stored in the sampler chunk of the audio file. Returns nil if the audio file does not contain an appropriate sampler chunk or could not be opened or is invalid.
---@field keyLow number The lowest key of the key range stored in the sampler chunk of the audio file. Returns nil if the audio file does not contain an appropriate sampler chunk or could not be opened or is invalid.
---@field keyHigh number The highest key of the key range stored in the sampler chunk of the audio file. Returns nil if the audio file does not contain an appropriate sampler chunk or could not be opened or is invalid.
---@field velLow number The lowest velocity of the velocity range stored in the sampler chunk of the audio file. Returns nil if the audio file does not contain an appropriate sampler chunk or could not be opened or is invalid.
---@field velHigh number The highest velocity of the velocity range stored in the sampler chunk of the audio file. Returns nil if the audio file does not contain an appropriate sampler chunk or could not be opened or is invalid.
---@field detune number The tune offset in cents stored in the sampler chunk of the audio file. Returns nil if the audio file does not contain an appropriate sampler chunk or could not be opened or is invalid.
---@field level number The level offset in dB stored in the sampler chunk of the audio file. Returns nil if the audio file does not contain an appropriate sampler chunk or could not be opened or is invalid.
---@field tempo number The tempo in bpm stored in a data chunk of the audio file. Returns nil if the audio file does not contain an appropriate data chunk or could not be opened or is invalid.
---@field beats number The number of beats stored in a data chunk of the audio file. Returns nil if the audio file does not contain an appropriate data chunk or could not be opened or is invalid.
---@field signature number A pair of values for the numerator and denominator of the signature stored in a data chunk of the audio file. The values are nil if the audio file does not contain an appropriate data chunk or could not be opened or is invalid.
---@field sampleStart number The position of the sample start in samples stored in a data chunk of the audio file. Returns nil if the audio file does not contain an appropriate data chunk or could not be opened or is invalid.
---@field sampleEnd number The position of the sample end in samples stored in a data chunk of the audio file. Returns nil if the audio file does not contain an appropriate data chunk or could not be opened or is invalid.
---@field loops loop[] The loop start and end positions in samples stored in a data chunk of the audio file. The returned table is an array that contains tables with the fields loopStart and loopEnd for each loop. Returns nil if the audio file does not contain an appropriate data chunk or could not be opened or is invalid.
local _AudioFile = {}

---@alias loop {loopStart: number, loopEnd: number}
AudioFile = {}
---@param path string
---@return AudioFile
function AudioFile.open(path) end
---Function to analyze the pitch of an audio file.
---@param callback? function
---@param channel? number
function _AudioFile:analyzePitch(callback, channel) end
---Function to cancel a pitch analysis you started with analyzePitch.
---@param channel number
function _AudioFile:cancelPitchAnalysis(channel) end
---Function to analyze the onsets in an audio file.
---@param start number The start position in samples.
---@param length number The duration in samples. Set this to equal to or less than 0 to use all samples from the specified start  to the end of the sample.
---@param peakThreshold number The minimum level in decibels. Onsets with lower level are skipped. The value range is from -96 to 0.
---@param sensThreshold number The minimum weight in percent. Onsets with lower weight are skipped. The value range is from 0 to 100.
---@param minLength number The minimum duration between consecutive onsets in milliseconds. The value range is from 0 to 10000.
---@return number[]
function _AudioFile:getOnsets(start, length, peakThreshold, sensThreshold, minLength) end
---Function to analyze the levels in an audio file. 
---@param start number The start position in samples.
---@param length number The duration in samples. Set this to equal to or less than 0 to use all samples from the specified start to the end of the file.
---@param rms number If this is set to 0, the peak level of the specified range will be returned. If this is set to a value above 0, the RMS level over the specified range will be calculated.
---@return number number Returns the level of the specifed range as a linear value.
function _AudioFile:getPeak(start, length, rms) end
---Function to obtain the pitch of an audio file that has been analyzed with analyzePitch.
---@param start number The start position in samples.
---@param length number The duration in samples. Set this to less than or equal to 0 to use all samples from the specified start to the end of the file.
---@param channel? number Use this to specify the audio channel that was analyzed.
---@return number pitch A float value representing the pitch as MIDI note number with decimals for cents.
---@return boolean boolean return value true means that a pitch was detected in the specified range.
function _AudioFile:getPitch(start, length, channel) end
---Function to monitor the progress of analyzePitch.
---@param channel? number
---@return number progress Returns the progress as a float value between 0 and 1.
function _AudioFile:getPitchAnalysisProgress(channel) end


---@class Element The Element class is the base class for the classes Bus, Instance, Layer, Effect, MidiModule, ModulationMatrixRow, Slot and Zone.
---@field name string Returns the name of the element.
---@field id string Returns the unique ID of the element.
---@field type string Returns the type of the element.
---@field parameterDefinitions ParameterDefinition[] Returns an array with all ParameterDefinition objects of the element.
---@field parent Layer Returns the parent element in the Program Tree. This evaluates to nil if the element is the program.
---@field program Program Returns the program element in the Program Tree.
---@field level number Returns the level in the Program Tree hierarchy. The program equals level 1. Each sublayer adds +1 to the level.
local _Element = {}
---Function to find children in the specified Element object.
---@param recursive? boolean
---@param nameOrFilterFunction? string|function
---@return Element[]
function _Element:findChildren(recursive, nameOrFilterFunction) end
---Function to retrieve the Element object of a child in the specified Element object.
---@param nameOrPosition? string|number
---@return Element?
function _Element:getChild(nameOrPosition) end
---Function to read the current value of a parameter. The parameter can be determined by name or ID.
---@param nameOrID string|number
---@return any
function _Element:getParameter(nameOrID) end
---Function to retrieve the ParameterDefinition object for a parameter. 
---@param nameOrID string|number
---@return ParameterDefinition
function _Element:getParameterDefinition(nameOrID) end
---Function to read the current value of a parameter in the normalized range from 0 to 1.0.
---@param nameOrID string|number
---@return number
function _Element:getParameterNormalized(nameOrID) end
---Function to check if a parameter exists. The parameter can be determined by name or ID.
---@param nameOrID string|number
---@return boolean
function _Element:hasParameter(nameOrID) end
---Function to remove an element in the Program Tree from the parent element. 
function _Element:removeFromParent() end
---Function to change the name of an element in the Program Tree.
---@param name string
function _Element:setName(name) end
---Function to set the value of a parameter. The parameter can be determined by name or ID. The function will have no effect if the parameter does not exist.
---@param nameOrID string|number
---@param value any
function _Element:setParameter(nameOrID, value) end
---Function to set the value of a parameter in the normalized range from 0 to 1.0. 
---@param nameOrID string|number
---@param value number
function _Element:setParameterNormalized(nameOrID, value) end

---@class Bus: Element The Element object of a bus can be obtained with findBusses or getBus.
---@field isAuxBus boolean Returns true if this is an aux bus and false if it is not.
---@field auxNumber number The number of the corresponding aux bus.
---@field numChannels number The number of output channels of the bus.
---@field active boolean Returns true if the bus is active and false if it is not active.
---@field bypassMask number Determines if a bus follows the global inserts and Aux bypass buttons.
local _Bus = {}
---@return Bus
function Bus() end
---Function to find effects in the specified Element object.
---@param recursive? boolean
---@param nameOrFilterFunction? string|function
---@return Effect[]
function _Bus:findEffects(recursive, nameOrFilterFunction) end
---Function to retrieve the Effect object of an effect from the specified bus.
---@param nameOrPosition? string|number
---@return Effect
function _Bus:getEffect(nameOrPosition) end
---Function to insert an effect at a specific position in a destination bus.
---@param effect Effect
---@param position number
function _Bus:insertEffect(effect, position) end
---Function to add an effect to the specified destination bus.
---@param effect Effect
function _Bus:appendEffect(effect) end
---Function to remove an effect from a bus.
---@param effectOrPosition Effect|number
function _Bus:removeEffect(effectOrPosition) end
---Function to retrieve the currently assigned output bus of a zone or bus.
---@return Bus
function _Bus:getOutputBus() end
---Function to assign the output of a zone or bus to the specified output bus.
---@param bus Bus
function _Bus:setOutputBus(bus) end





---@class Effect: Element The Effect class inherits all properties and methods of the Element class.
---@field moduleType string Returns the effect type.
---@field bypassMask number Determines if an effect follows the global inserts and Aux bypass buttons.


---Constructor to create a new Effect object of the specified type.
---@param type string The type of effect.
---@return Effect
function Effect(type) end



---@class Instance: Element The Instance class inherits all properties and methods of the Element class.
local _Instance = {}
---Function to find busses in the specified Element object.
---@param recursive? boolean
---@param nameOrFilterFunction? string|function
---@return Bus[]
function _Instance:findBusses(recursive, nameOrFilterFunction) end
---Function to find effects in the specified Element object.
---@param recursive? boolean
---@param nameOrFilterFunction? string|function
---@return Effect[]
function _Instance:findEffects(recursive, nameOrFilterFunction) end
---Function to find the slots of the plug-in instance. Before calling this function you must access the Instance object with this.program.instance.
---@param nameOrFilterFunction? string|function
---@return Slot[]
function _Instance:findSlots(nameOrFilterFunction) end
---Function to retrieve the Bus object of a bus in the specified Element object.
---@param nameOrPosition? string|number
---@return Bus?
function _Instance:getBus(nameOrPosition) end
---Function to retrieve the Slot object of a slot of the plug-in instance.
---@param nameOrIndex? string|number
---@return Slot?
function _Instance:getSlot(nameOrIndex) end
---Function to retrieve the Program object of a program in the Program Table of the plug-in instance.
---@param index number
---@return Program
function _Instance:getProgram(index) end
---Function to set a program in the specified slot of the Program Table or the Slot Rack of the plug-in instance.
---@param programOrNil Program|nil
---@param index? number
function _Instance:setProgram(programOrNil, index) end



---@class Layer: Element The Layer class inherits all properties and methods of the Element class.
local _Layer = {}
---Constructor to create a new Layer object.
---@return Layer
function Layer() end
---Function to add a bus in the specified destination layer.
---@param bus Bus
function _Layer:appendBus(bus) end
---Function to add a layer in the specified destination layer.
---@param layer Layer
function _Layer:appendLayer(layer) end
---Function to add a layer in the specified destination layer using a separate, parallel thread.
---@param layer Layer
---@param callback? function
---@return LoadProgress
function _Layer:appendLayerAsync(layer, callback) end
---Function to add a MIDI module in the specified destination layer.
---@param module MidiModule
function _Layer:appendMidiModule(module) end
---Function to add a zone in the specified destination layer.
---@param zone Zone
function _Layer:appendZone(zone) end
---Function to find busses in the specified Element object.
---@param recursive? boolean
---@param nameOrFilterFunction? string|function
---@return Bus[]
function _Layer:findBusses(recursive, nameOrFilterFunction) end
---Function to find effects in the specified Element object.
---@param recursive? boolean
---@param nameOrFilterFunction? string|function
---@return Effect[]
function _Layer:findEffects(recursive, nameOrFilterFunction) end
---Function to find layers in the specified layer.
---@param recursive? boolean
---@param nameOrFilterFunction? string|function
---@return Layer[]
function _Layer:findLayers(recursive, nameOrFilterFunction) end
---Function to find MIDI modules in the specified layer.
---@param recursive? boolean
---@param nameOrFilterFunction? string|function
---@return MidiModule[]
function _Layer:findMidiModules(recursive, nameOrFilterFunction) end
---Function to find zones in the specified layer. 
---@param recursive? boolean
---@param nameOrFilterFunction? string|function
---@return Zone[]
function _Layer:findZones(recursive, nameOrFilterFunction) end
---Function to retrieve the Bus object of a bus in the specified Element object.
---@param nameOrPosition? string|number
---@return Bus
function _Layer:getBus(nameOrPosition) end
---Function to retrieve the Layer object of a layer in the specified layer.
---@param nameOrPosition? string|number
---@return Layer
function _Layer:getLayer(nameOrPosition) end
---Function to retrieve the MidiModule object of a MIDI module in the specified layer.
---@param nameOrPosition? string|number
---@return MidiModule
function _Layer:getMidiModule(nameOrPosition) end
---Function to retrieve the Zone object of a zone in the specified layer.
---@param nameOrPosition? string|number
---@return Zone
function _Layer:getZone(nameOrPosition) end
---Function to insert a bus at the specified position in the destination layer.
---@param bus Bus
---@param position number
function _Layer:insertBus(bus, position) end
---Function to insert a layer at a specific position in a destination layer.
---@param layer Layer
---@param position number
function _Layer:insertLayer(layer, position) end
---Function to insert a layer at a specified position in a destination layer using a separate, parallel thread.
---@param layer Layer
---@param position number
---@param callback? function
---@return LoadProgress
function _Layer:insertLayerAsync(layer, position, callback) end
---Function to insert a MIDI module at the specified position in the determined destination layer.
---@param module MidiModule
---@param position number
function _Layer:insertMidiModule(module, position) end
---Function to insert a zone at the specified position in the determined layer.
---@param zone Zone
---@param position number
function _Layer:insertZone(zone, position) end
---Function to remove a bus from the specified layer.
---@param busOrPosition Bus|number
function _Layer:removeBus(busOrPosition) end
---Function to remove a layer from the specified layer.
---@param layerOrPosition Layer|number
function _Layer:removeLayer(layerOrPosition) end
---Function to remove a MIDI module from the specified layer.
---@param moduleOrPosition MidiModule|number
function _Layer:removeMidiModule(moduleOrPosition) end
---Function to remove a zone from the specified layer.
---@param zoneOrPosition Zone|number
function _Layer:removeZone(zoneOrPosition) end
---Function to add a quick control assignment to the specified layer and quick control.
---@param qc number
---@param element Element
---@param nameOrID string|number
---@param scope Element
function _Layer:addQCAssignment(qc, element, nameOrID, scope) end
---Function to remove a quick control assignment from the specified layer and quick control.
---@param qc number
---@param assignment number
function _Layer:removeQCAssignment(qc, assignment) end
---Function to retrieve the number of assignments of a quick control on the specified layer.
---@param qc number
---@return number
function _Layer:getNumQCAssignments(qc) end
---Function to retrieve the parameter ID of the parameter that is connected to the specified quick control assignment. 
---@param qc number
---@param assignment number
---@return number
function _Layer:getQCAssignmentParamId(qc, assignment) end
---Function to retrieve the element object that is set as scope for the specified quick control assignment.
---@param qc number
---@param assignment number
---@return Element
function _Layer:getQCAssignmentScope(qc, assignment) end
---Function to retrieve the minimum value of the specified quick control assignment.
---@param qc number
---@param assignment number
---@return number
function _Layer:getQCAssignmentMin(qc, assignment) end
---Function to retrieve the maximum value of the specified quick control assignment.
---@param qc number
---@param assignment number
---@return number
function _Layer:getQCAssignmentMax(qc, assignment) end
---Function to retrieve the curve value of the specified quick control assignment.
---@param qc number
---@param assignment number
---@return number
function _Layer:getQCAssignmentCurve(qc, assignment) end
---Function to retrieve the mode that is set for the specified quick control assignment.
---@param qc number
---@param assignment number
---@return number
function _Layer:getQCAssignmentMode(qc, assignment) end
---Function to retrieve the bypass state of the specified quick control assignment.
---@param qc number
---@param assignment number
---@return boolean
function _Layer:getQCAssignmentBypass(qc, assignment) end
---Function to set the parameter ID for connecting the corresponding parameter to the specified quick control assignment. 
---@param qc number
---@param assignment number
---@param paramID number
function _Layer:setQCAssignmentParamId(qc, assignment, paramID) end
---Function to set the scope for the specified quick control assignment. 
---@param qc number
---@param assignment number
---@param scope Element
function _Layer:setQCAssignmentScope(qc, assignment, scope) end
---Function to set the minimum value of the specified quick control assignment.
---@param qc number
---@param assignment number
---@param min number
function _Layer:setQCAssignmentMin(qc, assignment, min) end
---Function to set the maximum value of the specified quick control assignment.
---@param qc number
---@param assignment number
---@param max number
function _Layer:setQCAssignmentMax(qc, assignment, max) end
---Function to set the curve value of the specified quick control assignment.
---@param qc number
---@param assignment number
---@param curve number
function _Layer:setQCAssignmentCurve(qc, assignment, curve) end
---Function to set the mode of the specified quick control assignment.
---@param qc number
---@param assignment number
---@param mode number|QCAssignmentMode
function _Layer:setQCAssignmentMode(qc, assignment, mode) end
---Function to set the bypass state of the specified quick control assignment.
---@param qc number
---@param assignment number
---@param bypass boolean
function _Layer:setQCAssignmentBypass(qc, assignment, bypass) end

---@enum QCAssignmentMode Enumerator to identify the different quick control assignment modes.
QCAssignmentMode = {
    absolute = 1,
    relative = 2,
    switch = 3,
    switchRelative = 4,
}


---@class Program: Layer The Program class inherits all properties and methods of the Layer class.
---@field instance Instance The Element object of the plug-in instance.
---@field assignedSlots Element[] An array with the Element objects of the slots to which this program is assigned.

---Constructor to create a new Program object.
---@return Program
function Program() end



---@class MidiModule: Element The MidiModule class inherits all properties and methods of the Element class.
---@field moduleType string Returns the MIDI module type.
local _MidiModule = {}
this = _MidiModule
---Constructor to create a new MidiModule object of the specified type.
---@param type string
---@return MidiModule
function MidiModule(type) end


---@class ModulationMatrixRow: Element The ModulationMatrixRow class inherits all properties and methods of the Element class.
---@field rowNumber number Returns the index of the modulation matrix row.
---@field zone Zone Returns the Zone object of the zone that the modulation matrix row belongs to.
local _ModulationMatrixRow = {}
---Function to set the 1st modulation source of a row in the modulation matrix.
---@param source ModulationSource|number
---@param sourceInfo1? number|Element
---@param sourceInfo2? number
function _ModulationMatrixRow:setSource1(source, sourceInfo1, sourceInfo2) end
---Function to set the 2nd modulation source of a row in the modulation matrix.
---@param source ModulationSource|number
---@param sourceInfo1? number|Element
---@param sourceInfo2? number
function _ModulationMatrixRow:setSource2(source, sourceInfo1, sourceInfo2) end
---Function to retrieve the 1st modulation source of a row in the modulation matrix.
---@return ... Returns up to three values, i.e., source, sourceInfo1 and sourceInfo2. The number of return values depends on the modulation source.
function _ModulationMatrixRow:getSource1() end
---Function to retrieve the 2nd modulation source of a row in the modulation matrix.
---@return ... Returns up to three values, i.e., source, sourceInfo1 and sourceInfo2. The number of return values depends on the modulation source.
function _ModulationMatrixRow:getSource2() end

---@enum ModulationSource Enumerator to identify the different modulation sources.
ModulationSource = {
    unassigned = 0,
    lfo1 = 1,
    lfo2 = 2,
    ampEnv = 3,
    filterEnv = 4,
    pitchEnv = 5,
    userEnv = 6,
    stepMod = 7,
    glide = 8,
    keyFollow = 9,
    noteOnVelocity = 10,
    noteOnVelocitySquared = 11,
    noteOnVelocityNormalized = 12,
    noteOffVelocity = 13,
    pitchBend = 14,
    modWheel = 15,
    aftertouch = 16,
    midiControl = 17,
    quickControl = 18,
    modulationModule = 19,
    noteExpression = 20,
    noise = 21,
    output = 22,
    bus1 = 23,
    bus2 = 24,
    bus3 = 25,
    bus4 = 26,
    bus5 = 27,
    bus6 = 28,
    bus7 = 29,
    bus8 = 30,
    bus9 = 31,
    bus10 = 32,
    bus11 = 33,
    bus12 = 34,
    bus13 = 35,
    bus14 = 36,
    bus15 = 37,
    bus16 = 38,
    sampleAndHold = 41,
}

---@enum ModulationDestination Enumerator to identify the modulation destinations.
ModulationDestination = {
    unassigned = 0,
    pitch = 1,
    cutoff = 2,
    resonance = 3,
    distortion = 4,
    morphX = 5,
    morphY = 6,
    cutoffOffset = 7,
    resonanceOffset = 8,
    level = 9,
    volume1 = 10,
    volume2 = 11,
    pan = 12,
    sampleStart = 13,
    speedFactor = 14,
    formantShift = 15,
    grainPosition = 16,
    grainDirection = 17,
    grainDuration = 18,
    grainLength = 19,
    grainPitch = 20,
    grainFormant = 21,
    grainLevel = 22,
    osc1Pitch = 23,
    osc1Level = 24,
    osc1Waveform = 25,
    osc1MultiDetune = 26,
    osc1MultiPan = 27,
    osc1MultiVoices = 28,
    osc2Pitch = 29,
    osc2Level = 30,
    osc2Waveform = 31,
    osc2MultiDetune = 32,
    osc2MultiPan = 33,
    osc2MultiVoices = 34,
    osc3Pitch = 35,
    osc3Level = 36,
    osc3Waveform = 37,
    osc3MultiDetune = 38,
    osc3MultiPan = 39,
    osc3MultiVoices = 40,
    subOscLevel = 41,
    ringModLevel = 42,
    noiseLevel = 43,
    lfo1Freq = 46,
    lfo1Shape = 47,
    lfo2Freq = 48,
    lfo2Shape = 49,
    ampEnvAttack = 50,
    ampEnvDecay = 51,
    ampEnvSustain = 52,
    ampEnvRelease = 53,
    filterEnvAttack = 54,
    filterEnvDecay = 55,
    filterEnvSustain = 56,
    filterEnvRelease = 57,
    pitchEnvStartLev = 58,
    pitchEnvAttack = 59,
    pitchEnvAttLev = 60,
    pitchEnvDecay = 61,
    pitchEnvSustain = 62,
    pitchEnvRelease = 63,
    pitchEnvRelLev = 64,
    userEnvStartLev = 65,
    userEnvAttack = 66,
    userEnvAttLev = 67,
    userEnvDecay = 68,
    userEnvSustain = 69,
    userEnvRelease = 70,
    userEnvRelLev = 71,
    stepModFreq = 72,
    stepModSlope = 73,
    bus1 = 74,
    bus2 = 75,
    bus3 = 76,
    bus4 = 77,
    bus5 = 78,
    bus6 = 79,
    bus7 = 80,
    bus8 = 81,
    bus9 = 82,
    bus10 = 83,
    bus11 = 84,
    bus12 = 85,
    bus13 = 86,
    bus14 = 87,
    bus15 = 88,
    bus16 = 89,
    audioIn = 92,
    wavetable1Pitch = 93,
    wavetable1Level = 94,
    wavetable1Pan = 95,
    wavetable1MultiDetune = 96,
    wavetable1MultiPan = 97,
    wavetable1MultiSpread = 98,
    wavetable1MultiVoices = 99,
    wavetable1Pos = 100,
    wavetable1Dir = 102,
    wavetable1Speed = 104,
    wavetable2Pitch = 106,
    wavetable2Level = 107,
    wavetable2Pan = 108,
    wavetable2MultiDetune = 109,
    wavetable2MultiPan = 110,
    wavetable2MultiSpread = 111,
    wavetable2MultiVoices = 112,
    wavetable2Pos = 113,
    wavetable2Dir = 115,
    wavetable2Speed = 117,
    wavetableSubPitch = 119,
    wavetableSubLevel = 120,
    wavetableSubPan = 121,
    wavetableNoiseSpeed = 122,
    wavetableNoiseLevel = 123,
    wavetableNoisePan = 124,
    wavetable1FormantShift = 125,
    wavetable2FormantShift = 126,
}

---@class Slot: Element The Slot class inherits all properties and methods of the Element class.
local _Slot = {}
---Function to find busses in the specified Element object.
---@param recursive? boolean
---@param nameOrFilterFunction? string|function
---@return Bus[]
function _Slot:findBusses(recursive, nameOrFilterFunction) end
---Function to find effects in the specified Element object.
---@param recursive? boolean
---@param nameOrFilterFunction? string|function
---@return Effect[]
function _Slot:findEffects(recursive, nameOrFilterFunction) end
---Function to retrieve the Bus object of a bus in the specified Element object.
---@param nameOrPosition? string|number
---@return Bus
function _Slot:getBus(nameOrPosition) end
---Function to set a program in the specified slot of the Program Table or the Slot Rack of the plug-in instance.
---@param programOrNil Program|nil
---@param index? number
function _Slot:setProgram(programOrNil, index) end



---@class Zone: Element The Zone class inherits all properties and methods of the Element class.
---@field keyLow number The lowest key of the zone.
---@field keyHigh number The highest key of the zone.
---@field velLow number The lowest velocity of the zone.
---@field velHigh number The highest velocity of the zone.
local _Zone = {}
---Constructor to create a new Zone object.
---@return Zone
function Zone() end
---Function to obtain the ModulationMatrixRow object of the specified modulation matrix row.
---@param rowNumber number
---@return ModulationMatrixRow
function _Zone:getModulationMatrixRow(rowNumber) end
---Function to retrieve the currently assigned output bus of a zone or bus.
---@return Bus
function _Zone:getOutputBus() end
---Function to assign the output of a zone or bus to the specified output bus. 
---@param bus Bus|nil
function _Zone:setOutputBus(bus) end



---@class Event The Event class describes the properties of events.
---@field type number The type of event.
---@field id number The ID of the event.
---@field note number The note number in the range of 0 to 127.
---@field velocity number The note-on velocity in the
---@field controller number The controller number.
---@field value number The value of a controller, pitch bend, or note expression event. The value range depends on the event type.
---@field bend number The value of a pitch bend event in the range of -1.0 to 1.0.
---@field noteExpressionType number The type of note expression event.
---@field ppqPosition number The position of the event in ppq relative to the song start. The host must be in in playback. This value will be 0.0 if the host is not in playback.

---Constructor to create a new Event object of the specified type.
---@param type number|EventType
---@return Event
function Event(type) end

---@enum EventType Enumerator to identify the different types of events.
EventType = {
    noteOn = 1,
    noteOff = 2,
    controller = 3,
    noteExpression = 4,
    programChange = 5,
}
---@alias noteOn {type:1, id:number, note:number, velocity:number, ppqPosition:number }
---@alias noteOff {type:2, id:number, note:number, velocity:number, ppqPosition:number }
---@alias controller {type:3, controller:number, value:number, bend:number, ppqPosition:number }
---@alias noteExpression {type:4, id:number, value:number, noteExpressionType:number, ppqPosition:number }

---@enum NoteExpressionType Enumerator to identify the different note expression types.
NoteExpressionType = {
    volume = 1,
    pan = 2,
    tuning = 3,
    custom1 = 4,
    custom2 = 5,
    custom3 = 6,
    custom4 = 7,
    custom5 = 8,
    custom6 = 9,
    custom7 = 10,
    custom8 = 11,
}

---@class LoadProgress The properties of the LoadProgress class can be used to monitor the progress when loading elements of VST presets.
---@field progress number The load progress in the range from 0 to 1.
---@field root Layer|Program|Instance The value of .root will be the Element object of the first element (root) of the loaded VST preset.
---@field cancel boolean Set this to true to cancel the loading of the preset.
---@field error string Message if an error occured.
---@field info string|table User definable field, for example, to manage several loading threads.

---@class ParameterDefinition The ParameterDefinition class describes the properties of parameters.
---@field name string Returns the name of the parameter.
---@field longName string Returns the long name of the parameter.
---@field id number Returns the ID of the parameter.
---@field type string Returns the data type of the parameter.
---@field default number Returns the default value of the parameter.
---@field min number Returns the minimum value of the parameter.
---@field max number Returns the maximum value of the parameter.
---@field readOnly boolean Returns true if the value of the parameter is read-only and false if it is not.
---@field writeAlways boolean Returns true if the value is always set and false if it is not. If this returns true, the parameter sends a changed message even if the actual value did not change when it was set.
---@field automatable boolean Returns true if the parameter can be automated and false if it cannot.
---@field persistent boolean Returns true if the parameter restores from the VST preset and false if it does not.
---@field unit string Returns the unit of the parameter value, for example, dB.
local _ParameterDefinition = {}
---You can use this function to obtain the display string of the specified parameter and value.
---@param value number|string
---@return string
function _ParameterDefinition:getDisplayString(value) end



---Function that gives access to protected layers.
---@param pwd string
function addLayerPassword(pwd) end
---Function to generate channel aftertouch events.
---@param value number The aftertouch value in the range of 0 to 127.
function afterTouch(value) end

---@alias alternateData {keyswitch:number, layer:Layer}[] describes asdsad sdsad


---Function to assign a parameter to an automation parameter.
---@param element Element The Element object of the parameter to be assigned.
---@param nameOrID string|number The name or ID of the parameter.
---@param index number|nil The index of the automation parameter, or nil.
---@param scope Element The Element object that will be affected by the automation parameter.
---@return number index Returns the index to which the automation parameter was assigned to.
function assignAutomation(element, nameOrID, index, scope) end
---Function to convert a number of beats to the equivalent duration in milliseconds.
---@param beats number The desired duration in number of beats and fractions of it.
---@return number ms Returns the specified number of beats (quarter notes) as duration in milliseconds.
function beat2ms(beats) end
---Function to generate the modulation signals that have been defined with defineModulation.
---@return any #Returns one or more modulation signals. Multiple modulation signals can be returned as a tuple or as a table. If the modulation is defined as unipolar, the signal must be in the range from 0.0 to 1.0. If the modulation is defined as bipolar, the signal must be in the range from -1.0 to 1.0.
function calcModulation() end
---Function to change the note expression of a specific note.
---@param noteID number The ID of the note you want to change.
---@param type NoteExpressionType|number The note expression type. It can be determined via names or indices.
---@param value number The absolute note expression value in the range of 0.0 to 1.0 (relative = false) or the value that is added (relative = true).
---@param relative? boolean The value is added to the current amount if this is set to true. The default setting is false.
---@param immediateOrDuration? boolean Change the value immediately or in the specified duration.
function changeNoteExpression(noteID, type, value, relative, immediateOrDuration) end
---Function to change the position of a specific note in the panorama.
---@param noteID number The ID of the note that you want to change.
---@param pan number The absolute pan position in the range of -1.0 to 1.0 (relative = false) or the value which is added (relative = true).
---@param relative? boolean The value is added to the current amount if this is set to true. The default is false.
---@param immediateOrDuration? boolean|number Change the value immediately or in the specified duration.
function changePan(noteID, pan, relative, immediateOrDuration) end
---Function to change the tuning of a specific note in semitones.
---@param noteID number The ID of the note that you want to change.
---@param tune number The absolute tuning in the range of -120.0 to 120.0 semitones (relative = false) or the value which is added (relative = true).
---@param relative? boolean The value is added to the current amount if this is set to true. The default is false.
---@param immediateOrDuration? boolean|number Change the value immediately or in the specified duration.
function changeTune(noteID, tune, relative, immediateOrDuration) end
---Function to change the volume of a specific note. A gain factor greater than 1.0 amplifies the signal and a gain factor smaller than 1.0 attenuates the signal.
---@param noteID number The ID of the note that you want to change.
---@param gain number The absolute gain (relative = false) or the value which is added (relative = true).
---@param relative? boolean The value is added to the current amount if this is set to true. The default is false.
---@param immediateOrDuration? boolean|number Change the value immediately or in the specified duration.
function changeVolume(noteID, gain, relative, immediateOrDuration) end
---Function to change the volume of a specific note in decibels (dB). Positive values amplify the signal and negative values attenuate the signal.
---@param noteID number The ID of the note that you want to change.
---@param gain_dB number The absolute gain in dB (relative = false) or the value which is added (relative = true).
---@param relative? boolean The value is added to the current amount if  this is set to true. The default is false.
---@param immediateorDuration? boolean|number Change the value immediately or in the specified duration.
function changeVolumedB(noteID, gain_dB, relative, immediateorDuration) end
---Function to create a copy of the specified object.
---@param object Bus|Effect|Event|Layer|MidiModule|Program|Zone The object to be cloned.
---@return Bus|Effect|Event|Layer|MidiModule|Program|Zone #Returns a copy of the specified object.
function clone(object) end
---Function to generate controller events.
---@param controller number The controller number.
---@param value number The controller value in the range of 0 to 127.
function controlChange(controller, value) end
---Function to declare a modulation output for the script module, which can be assigned in the modulation matrix of the zone.
---@param name string The name of the modulation output as it will be shown in the modulation matrix of the zone.
---@param bipolar boolean If this is set to true, the output is expected to be in the range from -1.0 to 1.0. If this is set to false, the output is expected to be in the range from 0.0 to 1.0.
function defineModulation(name, bipolar) end
---Function to specify a parameter with the specified name and characteristics.
---@param name string
---@param ... any
function defineParameter(name, ...) end
---Function to attain global variables that operate independently per slot.
---@param name string The name of the global variable.
function defineSlotLocal(name) end
---Function to terminate an undo block.
function endUndoBlock() end
---Function to fade the volume of a specific note.
---@param noteID number The ID of the note you want to fade.
---@param startValue number|nil The start value of the fade in the range of 0 to 1.0. Set this to nil to start the fade from the current value of a running fade.
---@param targetValue number The target value of the fade in the range of 0 to 1.0.
---@param duration number The length of the fade in milliseconds. The target value is set instantaneously if this is set to <= 0.
---@param killVoice? boolean Set this to true to kill the note when the target value reached. The default is false.
function fade(noteID, startValue, targetValue, duration, killVoice) end
---Function to remove the specified parameter from its automation parameter.
---@param element Element The Element object of the parameter to be removed.
---@param nameOrID string|number The name or ID of the parameter.
function forgetAutomation(element, nameOrID) end
---Function to obtain the number of bytes which have been allocated to the script in the memory.
---@return number #Returns the number of bytes which have been allocated to the script in the memory.
function getAllocatedMemory() end
---Function to retrieve the index of the automation parameter to which the specified parameter is assigned.
---@param element Element The Element object of the parameter to be connected.
---@param nameOrID string|number The ID of the parameter.
---@return number|nil #Returns the the index of the automation parameter to which the specified parameter is assigned, or nil if the specified parameter is not assigned.
function getAutomationIndex(element, nameOrID) end
---Function to obtain the duration of one bar in milliseconds.
---@return number #Returns the duration of one bar in milliseconds based on the current time signature and tempo.
function getBarDuration() end
---Function to obtain the duration of one beat in milliseconds.
---@return number #Returns the duration of one beat in milliseconds.
function getBeatDuration() end
---Function to obtain the current song position in number of beats (quarter notes).
---@return number #When the host is in playback, the function returns a decimal with the number of beats (quarter notes) since the start of the song. The start of the song equals 0 beats. The function returns -1 if the host is not in playback.
function getBeatTime() end
---Function to obtain the position in the current bar in number of beats (quarter notes).
---@return number #When the host is in playback, the function returns a decimal with the number of beats (quarter notes) since the start of the current bar. The start of the bar equals 0 beats. The function returns -1 if the host is not in playback.
function getBeatTimeInBar() end
---Function to read the current value of a continuous controller.
---@param controller number The controller number.
---@return number #Returns the current value of the continuous controller specified by the argument.
function getCC(controller) end
---Function to obtain the name of the context.
---@return string #Returns a string with the name of the context in which the function is called.
function getContext() end
---Function to obtain the Element object of an element that has a macro page.
---@return Layer|MidiModule #Returns the Element object of the element to which the macro page is attached.
function getElement() end
---Function to retrieve the number of free voices of the plug-in instance.
---@return number #Returns the number of free voices of the plug-in instance.
function getFreeVoices() end
---Function to retrieve the name of the host software.
---@return string #Returns a string with the name of the host software.
function getHostName() end
---Function to retrieve the version of the host software.
---@return string #Returns a string with the version of the host software.
function getHostVersion() end
---Function to access the internal key properties array.
---@return keyProperty[] #Returns the reference to the internal key properties array.
function getKeyProperties() end

---@alias keyProperty {color:number, tooltip:string, drummap:string}
---@alias keySwitch {name:string, keyMin:number, keyMax:number, keyRemapped:number}

---Function to access the internal key switch array.
---@return keySwitch[] #Returns the internal key switch array.
function getKeySwitches() end
---Function to obtain the current song position in milliseconds.
---@return number #When the host is in playback, the function returns a decimal with the milliseconds since the start of the song. The start of the song equals 0 ms. The function returns -1 if the host is not in playback.
function getMsTime() end
---Function to measure the time delta between the last note-on event of the specified note and the call of this function.
---@param note number The note number in the range of 0 to 127.
---@return number ms Returns the time delta in milliseconds.
function getNoteDuration(note) end
---Function to read the current value of a note expression of a specific note.
---@param noteID number The note ID of the associated note.
---@param type NoteExpressionType|number The note expression type. It can be determined via names or indices.
---@return number #Returns the current value of the note expression determined by the arguments. The function returns -1 if the value of the note expression has not been set yet.
function getNoteExpression(noteID, type) end
---Function to access the internal array that manages the appearance of the custom note expressions.
---@return noteExpressionProperty[] #Returns the reference to the internal note expression properties array.
function getNoteExpressionProperties() end

---@alias noteExpressionProperty {name:string, block:boolean}

---Function to obtain the number of processed samples since the initialization of the plug-in.
---@return number #Returns the number of processed samples since the initialization of the plug-in.
function getProcessedSamples() end
---Function to retrieve the name of the plug-in.
---@return string #Returns a string with the name of the plug-in.
function getProductName() end
---Function to retrieve the version of the plug-in.
---@return string #Returns a string with the version of the plug-in.
function getProductVersion() end
---Function to retrieve the sample rate from the host software.
---@return number #Returns the sample rate of the host software in Hertz
function getSamplingRate() end
---Function to read the duration of the script execution time-out either for the controller or the processor thread, depending on where getScriptExecTimeOut is called.
---@return number #Returns the duration of the script execution time-out in milliseconds either for the controller or the processor thread.
function getScriptExecTimeOut() end
---Function to retrieve the version of the script engine.
---@return string #Returns a string with the version of the script engine.
function getScriptVersion() end
---Function to retrieve the index of the slot in which the program is loaded.
---@return number #Returns the index of the slot in which the program is loaded.
function getSlotIndex() end
---Function to read the tempo of the host software.
---@return number #Returns the current tempo in beats per minute (BPM). If no tempo information is available, this function returns the value -1.
function getTempo() end
---Function to obtain the time in milliseconds since the initialization of the script.
---@return number #Returns the time in milliseconds since the initialization of the script.
function getTime() end
---Function to read the time signature from the host software.
---@return number numerator
---@return number denominator
function getTimeSignature() end
---Function to check if the current script execution is part of an undo or redo operation.
---@return number|nil #The function returns 1 if the changes come from an undo operation, 2 if the changes come from a redo operation, nil if the changes do not come from an undo or redo operation.
function getUndoContext() end

---@enum UndoContext Enumerator to identify the undo context.
UndoContext = {
    inUndo = 1,
    inRedo = 2,
}

---Function to obtain the amount of memory that is used by the script.
---@return number #Returns the number of bytes in the memory that are used by the script.
function getUsedMemory() end
---Function to obtain the number of used voices of the plug-in instance.
---@return number #Returns the number of used voices of the plug-in instance.
function getUsedVoices() end
---Function to obtain the number of used voices of the slot in which a program is loaded.
---@return number #Returns the number of used voices of the corresponding slot.
function getUsedVoicesOfSlot() end
---Function to obtain the file path for the user VST presets of a product. If no product is set, the function returns the file path of the current plug-in.
---@param product? string The name of the product.
---@return string #Returns the file path for the user VST presets of the specified product.
function getUserPresetPath(product) end
---Function to retrieve the maximum number of voices of the plug-in instance as set in the Options editor.
---@return number #Returns the maximum number of voices of the plug-in instance.
function getVoices() end
---Function to insert an envelope point in the specified envelope.
---@param envelopeArray table An array with envelope points.
---@param index number The index of the point where the new point will be inserted.
---@param level number The level of the new point in the range from 0 to 1  for the filter and amplitude envelope or -1 to 1  for the pitch and user envelope.
---@param duration number The duration of the new point in the range from 0 to 30 seconds. The duration of the first point is always 0 seconds.
---@param curve number The curve of the new point in the range from -1 to 1.
function insertEnvelopePoint(envelopeArray, index, level, duration, curve) end
---Function to insert an event in the specified events table according to its PPQ position.
---@param eventsTable table The table record referencing the events table.
---@param event Event The Event object to be inserted.
function insertEvent(eventsTable, event) end
---Function to detect whether a key with a specific note number is held or not.
---@param note number The note number in the range of 0 to 127.
---@return boolean #Returns true if the key with the specified note number is held and false if the key has been released.
function isKeyDown(note) end
---Function to detect inside the onNote callback function if a note is held or not.
---@return boolean #Returns true if onNote has received a note-on event and false if onNote has received a corresponding note-off event.
function isNoteHeld() end
---Function to detect whether a key is held or not, regardless of the octave.
---@param note number The note number which specifies the key in the range of 0 to 127.
---@return boolean #Returns true if the specified key is held, no matter in which octave. The function returns false if the specified key and any octave keys have been released.
function isOctaveKeyDown(note) end
---Function to detect whether the host is in playback.
---@return boolean #Returns true if the host is in playback and false if not.
function isPlaying() end
---Function to load the elements of a VST preset.
---@param path string The path and file name of the VST preset.
---@return Layer|Program|Instance #Returns an Element object of the type Layer, Program or Instance, depending on whether a layer, program or multi-program VST preset was loaded.
function loadPreset(path) end
---Function to load the elements of a VST preset in a separate, parallel thread.
---@param path string The path and file name of the VST preset.
---@param callback? function Callback function that is called after the preset is loaded.
---@return LoadProgress #Returns a LoadProgress object.
function loadPresetAsync(path, callback) end
---Function to open a modal message box.
---@param stringOrConfigTable string|messageBoxConfigTable The message as a string or the configuration table that customizes the message box.
---@return number #Returns the result of the message box, i.e., which action closed the message box, as a number.
function messageBox(stringOrConfigTable) end

---@alias messageBoxConfigTable {type:number|MessageBoxType, text:string, button1:string, button2:string, button3:string}

---@enum MessageBoxType Enumerator to identify the types of the message box.
MessageBoxType = {
    warning = 1,
    question = 2,
    information = 3,
}

---@enum MessageBoxResult Enumerator to identify the results of the message box.
MessageBoxResult = {
    escape = 1,
    button1 = 2,
    button2 = 3,
    button3 = 4,
}

---Function to convert a duration in milliseconds to the equivalent number of beats. One beat equals a quarter note. The current tempo is taken into account.
---@param ms number The duration in milliseconds.
---@return number #Returns the number of beats (quarter notes) that is the equivalent of the specified duration.
function ms2beat(ms) end
---Function to convert a duration in milliseconds to the equivalent number of samples. The conversion takes into account the sample rate at which the plug-in runs.
---@param ms number The duration in milliseconds.
---@return number #Returns the number of samples that is the equivalent of the specified duration in milliseconds.
function ms2samples(ms) end
---This callback function is called when the script module receives a channel aftertouch event.
---@param event Event
function onAfterTouch(event) end
---This callback function is called when the script module receives a continuous controller event.
---@param event Event
function onController(event) end
---This callback function is called periodically if the script is idle. Use this to monitor the progress of load operations, for example.
function onIdle() end
---This callback function is called after executing any global statements and the onLoadIntoSlot callback function. It is the first callback function that is called when the processor thread is initialized.
function onInit() end
---This callback function is called when the script module is loaded as part of a preset or project. The data that is passed on is the data that was returned by onSave when the script module was saved.
---@param data any
function onLoad(data) end
---This callback function is called when the program is loaded into the Slot Rack. Any global statements are executed in advance. onInit is called after onLoadIntoSlot.
function onLoadIntoSlot() end
---This callback function is called when loading a subpreset with a corresponding Preset Browser template. 
---@param section string The section as defined in the Preset Browser Custom template.
---@param data any The data that was returned by onSaveSubPreset.
function onLoadSubPreset(section, data) end
---This callback function is called when the script module receives a note-on event.
---@param event noteOn
function onNote(event) end
---This callback function is called when the script module receives a note expression event.
---@param event noteExpression
function onNoteExpression(event) end
---This callback function is called when the script module receives a pitch bend event.
---@param event Event
function onPitchBend(event) end
---This callback function is called when the script module receives a note-off event.
---@param event noteOff
function onRelease(event) end
---This callback function is called when the program is removed from the Slot Rack. 
function onRemoveFromSlot() end
---This callback function is called when the script module is saved as part of a preset or project. The data you pass on to the return statement will be stored with the preset or project.
---@return any data The returned data will be stored as part of the preset or project.
function onSave() end
---This callback function is called when saving a subpreset with a corresponding Preset Browser template.
---@param section string The section as defined in the Preset Browser Custom template.
---@return any data The returned data will be stored in a subpreset.
function onSaveSubPreset(section) end
---This callback function is called when the script module receives a trigger event from a trigger pad.
---@param number number The number of the trigger pad in the range from 1 to 8.
function onTriggerPad(number) end
---This callback function is called when the script module receives an event that is not handled by the specific event callback functions, e.g., onNote, onRelease, onController and onNoteExpression.
---@param event Event The Event object.
function onUnhandledEvent(event) end
---Function to open a  website in the web browser.
---@param adress string The internet adress of the website.
function openURL(adress) end
---Function to generate pitch bend events.
---@param value number The pitch bend value in the range of -1.0 to 1.0.
function pitchBend(value) end
---Function to generate note events.
---@param note number The note number of the note in the range of 0 to 127.
---@param velocity number The velocity of the note in the range of 0 to 127.
---@param duration? number The length of the note in milliseconds. The default is -1.
---@param layerOrZone? Layer|Zone The layer or zone which shall receive the note.
---@param volume? number The initial volume in the range of 0 to 1.0. The default is 1.0.
---@param pan? number The initial pan position in the range of -1.0 to 1.0. The default is 0.
---@param tune? number The initial tuning in the range of -120.0 to 120.0. The default is 0.
---@return number id Returns the note ID of the generated note.
function playNote(note, velocity, duration, layerOrZone, volume, pan, tune) end
---Function to send the trigger events of the Trigger Pads to subsequent modules of the script module.
---@param number number The number of the trigger pad in the range from 1 to 8.
function playTriggerPad(number) end
---Function to post the event to the engine. The second argument is optional. It allows you to delay the event by a specific time in milliseconds.
---@param event Event The Event object that will be posted.
---@param delay? number Delay time in milliseconds. The default is 0 ms.
---@return number id Returns a note ID in case of a note-on event, nil for any other type of event.
function postEvent(event, delay) end
---Receives any number of arguments and prints their values to the output window of the script module.
---@param value1 any
---@param value2 any
---@param ... any
function printRaw(value1, value2, ...) end
---Function to read a MIDI file (.mid). The function creates a MIDI sequence table that contains the data of the MIDI file.
---@param path string The path and file name of the MIDI file.
---@return midiSequenceTable #Returns a MIDI sequence table.
function readMidiFile(path) end

---@alias tracksTable {name:string, channel:number, events:Event[]}
---@alias signatureTable {numerator:number, denominator:number}
---@alias midiSequenceTable {format:number, smpteformat:number, division:number, tempo:number, signature:signatureTable, songname:string, tracks:tracksTable[]}

---@enum MidiFileFormat Enumerator to identify the different MIDI file formats.
MidiFileFormat = {
    singleMultiChannelTrack = 0,
    simultaneousTracks = 1,
}

---Function to release a note with a specific note ID.
---@param noteID number The note ID of the note you want to release.
function releaseVoice(noteID) end
---Executes a function in the controller thread. By calling runAsync in the processor thread, you can invoke a function that is executed in the controller thread.
---@param func function The name of the function to be called.
---@param arg1? any
---@param arg2? any
---@param ...? unknown
function runAsync(func, arg1, arg2, ...) end
---Executes a function in the processor thread. By calling runSync in the controller thread, you can invoke a function that is executed in the processor thread.
---@param func function The name of the function to be called.
---@param id? number If this is specified, another call to runSync with the same ID overwrites the previous function if it has not been executed yet.
function runSync(func, id) end
---Function to convert a number of samples to the equivalent duration in milliseconds. The sample rate at which the plug-in runs is taken into account.
---@param samples number The number of samples.
---@return number #Returns the specified number of samples as duration in milliseconds.
function samples2ms(samples) end
---Function to specify the maximum allowed execution time of a function call in the script.
---@param duration number The duration for the script execution time-out in milliseconds.
function setScriptExecTimeOut(duration) end
---Function to sort the events of the specified events table according to their PPQ position.
---@param eventsTable table
function sortEvents(eventsTable) end
---Calls a Lua function and executes it in a separate, parallel thread.
---@param func function The name of the function to be called.
---@param arg1? any
---@param arg2? any
---@param ...? unknown
function spawn(func, arg1, arg2, ...) end
---Function to combine multiple undo entries into one undo block.
---@param name string This will be displayed as entry in the undo history.
---@param id? number Set this to combine the undo blocks that refer to this ID.
---@return number ID Returns an ID that can be used to identify the undo block.
function startUndoBlock(name, id) end

---@enum StealMode Enumerator to identify the different voice group steal modes.
StealMode = {
    lastNotePriority = 1,
    firstNotePriority = 2,
    lowNotePriority = 3,
    highNotePriority = 4,
    stealLowestAmplitude = 5,
    stealReleasedNotes = 6,
}

---@alias voiceGroupsData {maxPolyphony:number, exclusiveGroup:number, stealMode:number}[]

---Function to suspend the execution of a callback for a specific time in milliseconds.
---@param ms number Time in ms.
function wait(ms) end
---Function to suspend the execution of a callback for a specific time. This time is specified in number of beats.
---@param beats number Time in number of quarter notes and fractions of it.
function waitBeat(beats) end
---Function to suspend the execution of the onNote callback until the note that called onNote gets released either by a corresponding note-off or sustain pedal off.
function waitForRelease() end
---Function to write a MIDI file (.mid) to disk.
---@param path string The path and file name of the MIDI file.
---@param midiSequence midiSequenceTable The MIDI sequence table that contains the data.
---@return boolean #Returns true if the MIDI file was written successfully and false if not.
function writeMidiFile(path, midiSequence) end