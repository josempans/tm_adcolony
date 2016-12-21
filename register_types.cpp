#include "register_types.h"
#include "object_type_db.h"
#include "core/globals.h"
#include "ios/src/tm_adcolony.h"

void register_tm_adcolony_types() {
    Globals::get_singleton()->add_singleton(Globals::Singleton("TMAdColony", memnew(TMAdColony)));
}

void unregister_tm_adcolony_types() {}
