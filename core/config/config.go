// core/config/config.go
package config

import (
    "io/ioutil"

    "gopkg.in/yaml.v3"
)

type Config struct {
    Server struct {
        Port int `yaml:"port"`
    } `yaml:"server"`
}

func Load(path string) (*Config, error) {
    data, err := ioutil.ReadFile(path)
    if err != nil {
        return nil, err
    }

    var c Config
    if err := yaml.Unmarshal(data, &c); err != nil {
        return nil, err
    }

    if c.Server.Port == 0 {
        c.Server.Port = 8080
    }

    return &c, nil
}
