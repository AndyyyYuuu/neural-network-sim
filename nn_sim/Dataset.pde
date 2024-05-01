public class DataPair{
  public double[] inputs;
  public double output;
  public DataPair(double[] inputs, double output){
    this.inputs = inputs;
    this.output = output;
    
  }
}
public abstract class Dataset{
  public ArrayList<DataPair> train = new ArrayList<DataPair>();
  public ArrayList<DataPair> valid = new ArrayList<DataPair>();
  public int trainIdx, validIdx, trainSize, validSize;
  public abstract DataPair randPoint();
  public Dataset(int trainSize, int validSize){
    this.trainSize = trainSize;
    this.validSize = validSize;
    for (int i=0; i<trainSize; i++){
      train.add(randPoint());
    }
    for (int i=0; i<validSize; i++){
      valid.add(randPoint());
    }
    shuffle();
  }
  
  public void shuffle(){
    trainIdx = (int)random(0, trainSize);
    validIdx = (int)random(0, validSize);
  }
  
  public DataPair getTrain(){
    return train.get(trainIdx);
  }
  
  public DataPair getValid(){
    return valid.get(validIdx);
  }
}

public class CircleDataset extends Dataset{
  public CircleDataset(int trainSize, int testSize){
    super(trainSize, testSize);
  }
  public DataPair randPoint(){
    float x1 = random(-5, 5);
    float x2 = random(-5, 5);
    if (dist(x1, x2, 0, 0) > 2.5){
      return new DataPair(new double[]{x1, x2}, -1);
    }
    return new DataPair(new double[]{x1, x2}, 1); 
  }
}
