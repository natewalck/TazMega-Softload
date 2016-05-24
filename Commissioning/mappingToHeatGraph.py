#!/usr/bin/python

import re
import plotly.plotly as py
import plotly.graph_objs as go
import time


def build_list(data_file, sample_size):
    sample_dataset = []
    with open(data_file) as probe_data:
        samples = []
        n = 1
        for line in probe_data:
            if not 'Count' in line and n <= sample_size:
                samples.append(re.sub(r"(.*:|, mean.*)", "", line).strip())
                n += 1
            else:
                n = 1
                sample_dataset.append(samples)
                samples = []
        # Catch the last set of samples and append them to the dataset
        sample_dataset.append(samples)
        return sample_dataset

# Requires plotly to be setup and API key set as per:
# https://plot.ly/python/getting-started/
def make_plotly(dataset):
    data = [
        go.Heatmap(
            z=dataset
        )
    ]
    timestr = time.strftime("%Y%m%d-%H%M%S")
    plot_url = py.plot(data, filename='printbed-heatmap' + timestr)
    return plot_url

def main():
    data_list = build_list('probemap.txt', 15)
    print(make_plotly(data_list))

if __name__ == '__main__':
    main()
