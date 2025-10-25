### If execute the following commands, uncomment them
SCENE_DIR="/workspace/360_v2"
SCENE_LIST="garden bicycle stump bonsai counter kitchen room" # treehill flowers
POSTFIXES="_variance _contrast _contrast"

RESULT_DIR="/workspace/wild"

for POSTFIX in $POSTFIXES; do
  for SCENE in $SCENE_LIST;
  do

      if [ "$SCENE" = "bonsai" ] || [ "$SCENE" = "counter" ] || [ "$SCENE" = "kitchen" ] || [ "$SCENE" = "room" ]; then
          DATA_FACTOR=2
      else
          DATA_FACTOR=4
      fi

      echo "Running $SCENE on $POSTFIX"

      SOURCE=$SCENE_DIR/"$SCENE"/

      CUDA_VISIBLE_DEVICES=0 python ./train.py --source_path $SOURCE \
        --scene_name $SCENE --model_path $RESULT_DIR/"$POSTFIX"/"$SCENE"/ --eval --resolution 2 --iterations 10000 \
        --postfix "$POSTFIX"
  done
done
