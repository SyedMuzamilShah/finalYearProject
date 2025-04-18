abstract class UseCaseAbstract<Type, Prams> {
  Future<Type> call({required Prams prams});
}