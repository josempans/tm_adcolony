/*
    AdColony module for Godot
    by José M. Pan
*/

#ifndef TM_ADCOLONY_H
#define TM_ADCOLONY_H

#include "core/object.h"

class TMAdColony : public Object {
    OBJ_TYPE(TMAdColony, Object);

    static void _bind_methods();
    static TMAdColony* instance;
    bool initialized;

public:
    static TMAdColony* getInstance() { return instance; }
    void setup(String app_id, String zone_id);
    void requestInterstitial();
    void launchInterstitial();
    void emitAdFinishedSignal();

    TMAdColony();
    ~TMAdColony();
};



#endif /* JMP_ADCOLONY_H */
