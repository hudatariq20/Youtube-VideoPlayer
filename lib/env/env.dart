import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
    @EnviedField(obfuscate: true)
    static String MUX_TOKEN_ID = _Env.MUX_TOKEN_ID;

    @EnviedField(obfuscate: true)
    static String MUX_SECRET_KEY  = _Env.MUX_SECRET_KEY;
}