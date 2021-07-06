import argparse
import shutil
from pathlib import Path

import fiftyone as fo
from fiftyone import ViewField as F


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='Typical usage: python3 merge_coco_datasets.py \ \n' +
               '-j <path_to_coco_json_1> -i <path_to_images_1> \ \n' +
               '-j <path_to_coco_json_2> -i <path_to_images_2> \ \n' +
               '-o <path_to_output_dataset>'
    )
    parser.add_argument('-j', '--json', help='path to coco json', action='append', required=True)
    parser.add_argument('-i', '--image_dir', help='path to images directory', action='append', required=True)
    parser.add_argument('-o', '--output', help='path to output directory', required=True)
    args = parser.parse_args()


    assert len(args.image_dir) == len(args.json), "Number of images directory must be same as number of jsons"

    all_datasets = {}
    for i, (json_path, images_dir_path) in enumerate(zip(args.json, args.image_dir)):
        all_datasets[i] = fo.Dataset.from_dir(
            dataset_type=fo.types.COCODetectionDataset,
            data_path=images_dir_path,
            labels_path=json_path,
        )

        print(f'dataset {i} size: {len(all_datasets[i])}')

        if i > 0:
            all_datasets[0].merge_samples(all_datasets[i], overwrite_info=True)
            print(f'merged dataset size: {len(all_datasets[0])}')

    export_dir = Path(args.output)
    if export_dir.is_dir():
        if input(f'{export_dir.name} will be overwritten. Are you sure? y/n: ') == 'y':
            shutil.rmtree(export_dir)
            all_datasets[0].export(
                dataset_type=fo.types.COCODetectionDataset,
                export_dir=str(export_dir),
                label_field="ground_truth"
            )
