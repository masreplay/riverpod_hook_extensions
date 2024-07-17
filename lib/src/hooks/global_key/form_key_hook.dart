import 'package:flutter/material.dart';

import 'global_key_hook.dart';

GlobalKey<FormState> useFormKey() {
  return useGlobalKey<FormState>();
}
