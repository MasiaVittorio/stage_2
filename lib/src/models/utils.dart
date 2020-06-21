part of stage;

class _StageUtils {

  static bool _compareMaps<T,S>(
    Map<T,S> first, 
    Map<T,S> second, [
      bool compareValue(S one,S two)
    ]
  ){
    if(first == null && second == null)
      return true;
    if(first == null || second == null)
      return false;
    if(first.length != second.length)
      return false;
    for(final entry in first.entries){
      if(!second.containsKey(entry.key)){
        return false;
      } else {
        if(compareValue != null){
          if(!compareValue(
            entry.value,
            second[entry.key],
          )) return false;
        } else {
          if(entry.value != second[entry.key])
            return false;
        }
      }
    }

    return true;
  }
}